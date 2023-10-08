#include <Trade\Trade.mqh>

// Create an instance of CTrade
CTrade trade;

void OnTick()
{
    // Calculate Ask and Bid prices
    double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
    double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);

    // Create an array for prices and copy price data
    MqlRates PriceInfo[];
    ArraySetAsSeries(PriceInfo, true);
    int PriceData = CopyRates(Symbol(), Period(), 0, 3, PriceInfo);

    // Create an array for CCI values
    double myPriceArray[];

    // Define the properties of the CCI EA
    int CCIDefinition = iCCI(_Symbol, _Period, 14, PRICE_CLOSE);

    // Sort the price array from the current candle downwards
    ArraySetAsSeries(myPriceArray, true);

    // Calculate CCI values
    CopyBuffer(CCIDefinition, 0, 0, 3, myPriceArray);

    // Get the value of the current candle
    double CCIValue = myPriceArray[0];

    // Determine the trade signal based on CCI value
    string signal = "";
    if (CCIValue > 100)
        signal = "sell";
    else if (CCIValue < -100)
        signal = "buy";

    // Execute trades based on the signal
    if (signal == "sell" && PositionsTotal() < 1)
        trade.Sell(0.10, NULL, Bid, 0, Bid - 150 * _Point, NULL);

    if (signal == "buy" && PositionsTotal() < 1)
        trade.Buy(0.10, NULL, Ask, 0, Ask + 150 * _Point, NULL);

    // Display the current signal on the chart
    Comment("The current signal is: ", signal);
}
