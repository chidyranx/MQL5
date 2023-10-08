#include <Trade\Trade.mqh>

// Create an instance of CTrade
CTrade trade;

void OnTick()
{
    // Calculate the Ask and Bid prices
    double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
    double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);

    // Create an array for the prices
    MqlRates PriceInfo[];

    // Sort the price array from the current candle downwards
    ArraySetAsSeries(PriceInfo, true);

    // Fill the array with the price data
    int PriceData = CopyRates(Symbol(), Period(), 0, 3, PriceInfo);

    // Create an array for the iTriX indicator data
    double myPriceArray[];

    // Define the properties of the iTriX EA
    int iTriXDefinition = iTriX(_Symbol, _Period, 14, PRICE_CLOSE);

    // Sort the price array from the current candle downwards
    ArraySetAsSeries(myPriceArray, true);

    // Copy iTriX values into the array
    CopyBuffer(iTriXDefinition, 0, 0, 3, myPriceArray);

    // Determine the signal based on iTriX value
    string signal = "";
    if (myPriceArray[0] > 0)
        signal = "buy";

    if (myPriceArray[0] < 0)
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
