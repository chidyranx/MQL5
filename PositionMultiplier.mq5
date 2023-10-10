// Import trade library
#include<Trade\Trade.mqh>

// Create an instance for CTrade
CTrade trade;

// External adjustable variable
input int NumberOfPositions = 1;

void OnTick()
{
    // Get the ask price
    double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);

    // Create a price array
    MqlRates PriceArray[];

    // Sort the array from the current candle downwards
    ArraySetAsSeries(PriceArray, true);

    // Fill the array with data for 3 candles
    int Data = CopyRates(_Symbol, _Period, 0, 3, PriceArray);

    // If last close price is higher than before
    if (PriceArray[2].close < PriceArray[1].close)
    {
        // If the number of trades is below the specified number of positions
        if (PositionsTotal() < NumberOfPositions)
        {
            // Buy 10 Microlot
            trade.Buy(0.10, NULL, Ask, 0, (Ask + 150 * _Point), NULL);
        }
    }
}
