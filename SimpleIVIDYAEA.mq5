#include <Trade\Trade.mqh>

// Create an instance of CTrade
CTrade trade;

void OnTick()
{
    // Calculate the Ask and Bid prices
    double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
    double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);

    // Create an empty string for the signal
    string signal = "";

    // Create a price array
    MqlRates PriceArray[];

    // Sort the array from the current candle downwards
    ArraySetAsSeries(PriceArray, true);

    // Fill the array with data for 3 candles
    int Data = CopyRates(_Symbol, _Period, 0, 3, PriceArray);

    // Create an array for the EA data
    double EAArray[];

    // Sort the array from the current candle downwards
    ArraySetAsSeries(EAArray, true);

    // Define the iVIDyA EA
    int iVIDyADefinition = iVIDyA(_Symbol, _Period, 9, 12, 0, PRICE_CLOSE);

    // Copy iVIDyA values into the array
    CopyBuffer(iVIDyADefinition, 0, 0, 3, EAArray);

    // Calculate the current iVIDyA value
    float iVIDyAValue = EAArray[0];

    // Calculate a signal
    if (iVIDyAValue > PriceArray[1].close)
        signal = "sell";

    if (iVIDyAValue < PriceArray[1].close)
        signal = "buy";

    // Sell 10 Microlot
    if (signal == "sell" && PositionsTotal() < 1)
        trade.Sell(0.10, NULL, Bid, 0, (Bid - 150 * _Point), NULL);

    // Buy 10 Microlot
    if (signal == "buy" && PositionsTotal() < 1)
        trade.Buy(0.10, NULL, Ask, 0, (Ask + 150 * _Point), NULL);

    // Create a chart output
    Comment("The current signal is: ", signal);
}
