#include <Trade\Trade.mqh>

// Create a CTrade instance
CTrade trade;

void OnTick()
{
    // Create a string for the signal
    string signal = "";

    // Get the Ask price
    double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);

    // Get the Bid price
    double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);

    // Create an array for the price data
    double myPriceArray0[];

    // Create another array for price data
    double myPriceArray1[];

    // Define the properties for the RVI EA
    int RVIDefinition = iRVI(_Symbol, _Period, 10);

    // Sort Array0 from the current candle downwards
    ArraySetAsSeries(myPriceArray0, true);

    // Sort Array1 from the current candle downwards
    ArraySetAsSeries(myPriceArray1, true);

    // Defined EA, first buffer, current Candle, 3 candles, store in Array0
    CopyBuffer(RVIDefinition, 0, 0, 3, myPriceArray0);

    // Defined EA, second buffer, current Candle, 3 candles, store in Array1
    CopyBuffer(RVIDefinition, 1, 0, 3, myPriceArray1);

    // Calculate the current value for line0
    double RVIValue0 = NormalizeDouble(myPriceArray0[0], 3);

    // Calculate the current value for line1
    double RVIValue1 = NormalizeDouble(myPriceArray1[0], 3);

    // Create a buy signal
    if (RVIValue0 < RVIValue1)
        if ((RVIValue0 < 0) && (RVIValue1 < 0))
        {
            signal = "buy";
        }

    // Create a sell signal
    if (RVIValue0 > RVIValue1)
        if ((RVIValue0 > 0) && (RVIValue1 > 0))
        {
            signal = "sell";
        }

    // Sell 10 Microlot
    if (signal == "sell" && PositionsTotal() < 1)
        trade.Sell(0.005, NULL, Bid, (Bid + 2000), (Bid - 6000), NULL);

    if (signal == "buy" && PositionsTotal() < 1)
        // Buy 10 Microlot
        trade.Buy(0.005, NULL, Ask, (Ask - 2000), (Ask + 6000), NULL);

    Comment("Signal: ", signal);
}
