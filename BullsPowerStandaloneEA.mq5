#include<Trade\Trade.mqh>

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
    double myPriceArray[];

    // Sort the array from the current candle downwards
    ArraySetAsSeries(myPriceArray, true);

    // Define the Bulls Power EA
    int BullsPowerDefinition = iBullsPower(_Symbol, _Period, 13);

    // Fill the array with data
    CopyBuffer(BullsPowerDefinition, 0, 0, 3, myPriceArray);

    // Calculate the array value
    float BullsPowerValue = myPriceArray[0];

    // If Bulls Power value is above 0
    if (BullsPowerValue > 0)
        signal = "buy";

    // If Bulls Power value is below 0
    if (BullsPowerValue < 0)
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
