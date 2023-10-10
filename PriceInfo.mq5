void OnTick()
{
   // Create an Array for price information
   MqlRates PriceInformation[];
   
   // Sort the array from the current candle to the oldest candle
   ArraySetAsSeries(PriceInformation, true);
   
   // Copy price data into the array
   int Data = CopyRates(Symbol(), Period(), 0, Bars(Symbol(), Period()), PriceInformation);
   
   // Compare the close of the last completed candle with the close of the second-to-last completed candle
   if (PriceInformation[1].close > PriceInformation[2].close)
       Comment("It is going up");
   
   if (PriceInformation[1].close < PriceInformation[2].close)
       Comment("It is going down");
}
