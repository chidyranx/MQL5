void OnTick()
{
   MqlRates PriceInformation[]; // Create an Array for price information
   
   ArraySetAsSeries(PriceInformation, true); // Sort the array from current candle to oldest candle
   
   int Data = CopyRates(Symbol(), Period(), 0, Bars(Symbol(), Period()), PriceInformation); // Copy price data into the array
   
   // Check if the previous candle is a Doji
   if (PriceInformation[1].open == PriceInformation[1].close)
   {
      // Chart Output for a Doji candle
      Comment("Candle 1 is a Doji");
   }
   else
   {
      // Chart Output for a non-Doji candle
      Comment("Candle 1 is not a Doji");
   }
}
