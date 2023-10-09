#include <Trade\Trade.mqh>

// Create an instance of CTrade
CTrade trade;

void OnTick()
{
    // Create a price array
    MqlRates PriceArray[];

    // Sort the array from the current candle downwards
    ArraySetAsSeries(PriceArray, true);

    // Fill the array with price data
    int Data = CopyRates(Symbol(), Period(), 0, 3, PriceArray);

    // Create a string for the signal
    string signal = "";

    // Calculate the Ask price
    double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);

    // Calculate the Bid price
    double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);

    // Create a SAR array
    double mySARArray[];

    // Define SAR EA, current candle, 3 candles, save the result
    int SARDefinition = iSAR(_Symbol, _Period, 0.02, 0.2);

    // Sort the array from the current candle downwards
    ArraySetAsSeries(mySARArray, true);

    // Define EA, current buffer, current candle, 3 candles, save in array
    CopyBuffer(SARDefinition, 0, 0, 3, mySARArray);

    // Calculate the value for the last candle
    double LastSARValue = NormalizeDouble(mySARArray[1], 5);

    // Calculate the value for the candle before the last candle
    double NextToLastSARValue = NormalizeDouble(mySARArray[2], 5);

    // Buy signal
    // If last SAR value is below the low of candle 1
    if (LastSARValue < PriceArray[1].low)

        // If it was above the high of the candle before
        if (NextToLastSARValue > PriceArray[2].high)

            signal = "buy";

    // Sell signal
    // If last SAR value is above the high of candle 1
    if (LastSARValue > PriceArray[1].high)

        // If it was below the low of the candle before
        if (NextToLastSARValue < PriceArray[2].low)

            signal = "sell";

    // Sell 10 Microlots
    if (signal == "sell" && PositionsTotal() < 1)
        trade.Sell(0.10, NULL, Bid, 0, (Bid - 150 * _Point), NULL);

    // Buy 10 Microlots
    if (signal == "buy" && PositionsTotal() < 1)
        trade.Buy(0.10, NULL, Ask, 0, (Ask + 150 * _Point), NULL);

    // Create a chart output
    Comment("The current signal is: ", signal);
}
