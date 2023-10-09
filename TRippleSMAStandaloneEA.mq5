#include <Trade\Trade.mqh>

// Create an instance of CTrade
CTrade trade;

void OnTick()
{
    // Calculate the Ask price
    double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);

    // Calculate the Bid price
    double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);

    // Create a price array
    MqlRates PriceInfo[];

    // Sort the array from the current candle downwards
    ArraySetAsSeries(PriceInfo, true);

    // Fill the array with price data
    int PriceData = CopyRates(Symbol(), Period(), 0, 3, PriceInfo);

    // Create a string for the signal
    string signal = "";

    // Create arrays for three SMAs
    double SMA10Array[], SMA50Array[], SMA100Array[];

    // Define the SMA10
    int SMA10Definition = iMA(_Symbol, _Period, 10, 0, MODE_SMA, PRICE_CLOSE);

    // Define the SMA50
    int SMA50Definition = iMA(_Symbol, _Period, 50, 0, MODE_SMA, PRICE_CLOSE);

    // Define the SMA100
    int SMA100Definition = iMA(_Symbol, _Period, 100, 0, MODE_SMA, PRICE_CLOSE);

    // Sort the arrays from the current candle downwards
    ArraySetAsSeries(SMA10Array, true);
    ArraySetAsSeries(SMA50Array, true);
    ArraySetAsSeries(SMA100Array, true);

    // Fill the arrays with price data
    CopyBuffer(SMA10Definition, 0, 0, 10, SMA10Array);
    CopyBuffer(SMA50Definition, 0, 0, 10, SMA50Array);
    CopyBuffer(SMA100Definition, 0, 0, 10, SMA100Array);

    // Buy signal
    if (SMA10Array[0] > SMA50Array[0])
        if (SMA50Array[0] > SMA100Array[0])
            signal = "Kaufen";

    // Sell signal
    if (SMA10Array[0] < SMA50Array[0])
        if (SMA50Array[0] < SMA100Array[0])
            signal = "Verkaufen";

    // Sell 10 Microlot
    if (signal == "Verkaufen" && PositionsTotal() < 1)
        trade.Sell(0.10, NULL, Bid, 0, (Bid - 150 * _Point), NULL);

    // Buy 10 Microlot
    if (signal == "Kaufen" && PositionsTotal() < 1)
        trade.Buy(0.10, NULL, Ask, 0, (Ask + 150 * _Point), NULL);

    // Create a chart output
    Comment("Das aktuelle Signal ist: ", signal);
}
