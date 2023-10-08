#include <Trade\Trade.mqh>

// Create a CTrade instance
CTrade trade;

void OnTick()
{
    // Create an empty string for entry
    string entry = "";

    // Get the Ask and Bid prices
    double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
    double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);

    // Create arrays for the moving average values
    double myMovingAverageArray20[], myMovingAverageArray50[];

    // Define the properties of the moving averages
    int movingAverageDefinition1 = iMA(_Symbol, _Period, 20, 0, MODE_EMA, PRICE_CLOSE);
    int movingAverageDefinition2 = iMA(_Symbol, _Period, 50, 0, MODE_EMA, PRICE_CLOSE);

    // Sort the arrays from the current candle downwards
    ArraySetAsSeries(myMovingAverageArray20, true);
    ArraySetAsSeries(myMovingAverageArray50, true);

    // Copy moving average values into the arrays
    CopyBuffer(movingAverageDefinition1, 0, 0, 3, myMovingAverageArray20);
    CopyBuffer(movingAverageDefinition2, 0, 0, 3, myMovingAverageArray50);

    // Check for a crossover: 20 EMA crossing above 50 EMA (buy signal)
    if (myMovingAverageArray20[0] > myMovingAverageArray50[0] && myMovingAverageArray20[1] < myMovingAverageArray50[1])
    {
        entry = "buy";
    }
    
    // Check for a crossover: 20 EMA crossing below 50 EMA (sell signal)
    if (myMovingAverageArray20[0] < myMovingAverageArray50[0] && myMovingAverageArray20[1] > myMovingAverageArray50[1])
    {
        entry = "sell";
    }

    // Execute trades based on the generated signal
    if (entry == "sell" && PositionsTotal() < 1)
        trade.Sell(0.10, NULL, Bid, 0, (Bid - 150 * _Point), NULL);

    if (entry == "buy" && PositionsTotal() < 1)
        trade.Buy(0.10, NULL, Ask, 0, (Ask + 150 * _Point), NULL);
}
