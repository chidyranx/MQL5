#include <Trade\Trade.mqh>

// Create an instance of CTrade
CTrade trade;

void OnTick()
{
   // Calculate the Ask price
   double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);

   // Calculate the Bid price
   double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);

   // Create an array for the prices
   MqlRates PriceInfo[];

   // Sort the price array from the current candle downwards
   ArraySetAsSeries(PriceInfo, true);

   // Fill the array with the price data
   int PriceData = CopyRates(Symbol(), Period(), 0, 3, PriceInfo);

   // Create a string variable for the signal
   string signal = "";

   // Create an array for several prices
   double myPriceArray[];

   // Define the properties of the AdaptiveMovingAverageValue EA  
   int AdaptiveMovingAverageDefinition = iAMA(_Symbol, _Period, 9, 2, 30, 0, PRICE_CLOSE);

   // Sort the price array from the current candle downwards
   ArraySetAsSeries(myPriceArray, true);

   // Define MA1, one line, current candle, 3 candles, store result 
   CopyBuffer(AdaptiveMovingAverageDefinition, 0, 0, 3, myPriceArray);

   // Get the value of the current candle
   double AdaptiveMovingAverageValue = NormalizeDouble(myPriceArray[0], 6);

   if (AdaptiveMovingAverageValue > PriceInfo[0].close)
      signal = "sell";

   if (AdaptiveMovingAverageValue < PriceInfo[0].close)
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
