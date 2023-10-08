#include <Trade\Trade.mqh>

// Create a CTrade instance
CTrade trade;

void OnTick()
{
    // Create an empty string for the entry signal
    string entry = "";

    // Get the Ask and Bid prices
    double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
    double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);

    // Create an array for Bollinger Bands values
    double upperBandArray[];
    double lowerBandArray[];

    // Sort the arrays from the current candle downwards
    ArraySetAsSeries(upperBandArray, true);
    ArraySetAsSeries(lowerBandArray, true);

    // Define Bollinger Bands
    int bollingerBandsDefinition = iBands(_Symbol, _Period, 20, 0, 2, PRICE_CLOSE);

    // Copy Bollinger Bands values into the arrays
    CopyBuffer(bollingerBandsDefinition, 1, 0, 3, upperBandArray);
    CopyBuffer(bollingerBandsDefinition, 2, 0, 3, lowerBandArray);

    // Get the Bollinger Bands values for the current and the previous candle
    double myUpperBandValue = upperBandArray[0];
    double myLowerBandValue = lowerBandArray[0];
    double myLastUpperBandValue = upperBandArray[1];
    double myLastLowerBandValue = lowerBandArray[1];

    // Check for re-entry signals
    if (PriceInfo[0].close > myLowerBandValue && PriceInfo[1].close < myLastLowerBandValue)
    {
        entry = "buy";
        // Buy 10 Microlots
        if (PositionsTotal() < 1)
            trade.Buy(0.10, NULL, Ask, 0, (Ask + 150 * _Point), NULL);
    }

    if (PriceInfo[0].close < myUpperBandValue && PriceInfo[1].close > myLastUpperBandValue)
    {
        entry = "sell";
        // Sell 10 Microlots
        if (PositionsTotal() < 1)
            trade.Sell(0.10, NULL, Bid, 0, (Bid - 150 * _Point), NULL);
    }

    // Chart output of the entry signal
    Comment("Entry Signal: ", entry);
}
