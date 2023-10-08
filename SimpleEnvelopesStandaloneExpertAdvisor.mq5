#include <Trade\Trade.mqh>

// Create an instance of CTrade
CTrade trade;

void OnTick()
{
    // Calculate the Ask price
    double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
    
    // Calculate the Bid price
    double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);

    // Create a string for the signal
    string signal = "";

    // Create an array for prices
    MqlRates PriceInformation[];

    // Sort the array from the current candle downwards
    ArraySetAsSeries(PriceInformation, true);

    // Copy price data into the array
    int Data = CopyRates(Symbol(), Period(), 0, 3, PriceInformation);

    // Create an array for the EA data
    double UpperBandArray[];
    double LowerBandArray[];

    // Sort the array from the current candle downwards
    ArraySetAsSeries(UpperBandArray, true);
    ArraySetAsSeries(LowerBandArray, true);

    // Define the Envelopes EA
    int EnvelopesDefinition = iEnvelopes(_Symbol, _Period, 14, 0, MODE_SMA, PRICE_CLOSE, 0.100);

    // Fill the array with data
    CopyBuffer(EnvelopesDefinition, 0, 0, 3, UpperBandArray);
    CopyBuffer(EnvelopesDefinition, 1, 0, 3, LowerBandArray);

    // Calculate the array values
    double myUpperBandValue = NormalizeDouble(UpperBandArray[0], 6);
    double myLowerBandValue = NormalizeDouble(LowerBandArray[0], 6);

    // If the last candle closed below the lower band
    if (PriceInformation[1].close < myLowerBandValue)
        signal = "buy";

    // If the last candle closed above the higher band  
    if (PriceInformation[1].close > myUpperBandValue)
        signal = "sell";

    // Sell 10 Microlot
    if (signal == "sell" && PositionsTotal() < 1)
        trade.Sell(0.10, NULL, Bid, 0, (Bid - 150 * _Point), NULL);

    // Buy 10 Microlot  
    if (signal == "buy" && PositionsTotal() < 1)
        trade.Buy(0.10, NULL, Ask, 0, (Ask + 150 * _Point), NULL);

    // Create a chart output
    Comment("The current signal is: ", signal);
}
