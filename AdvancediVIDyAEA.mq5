string CheckEntry()
{
   // Create a string variable for the signal
   string signal = "";

   // Create an array for the price data
   MqlRates PriceArray[];

   // Sort the price array from the current candle downwards
   ArraySetAsSeries(PriceArray, true);

   // Fill the price array with data for 3 candles
   int Data = CopyRates(_Symbol, _Period, 0, 3, PriceArray);

   // Create another array for the Expert Advisor
   double EAArray[];

   // Sort the array from the current candle downwards
   ArraySetAsSeries(EAArray, true);

   // Define the VIDyA EA
   int iVIDyADefinition = iVIDyA(_Symbol, _Period, 9, 12, 0, PRICE_CLOSE);

   // Defined EA, 1 Buffer, current candle, for 3 candles, store in array
   CopyBuffer(iVIDyADefinition, 0, 0, 3, EAArray);

   // Calculate the current value
   double IVIDYAVALUE = EAArray[0];

   // Buy signal
   if (IVIDYAVALUE > PriceArray[1].close)
      signal = "buy";

   // Sell signal
   if (IVIDYAVALUE < PriceArray[1].close)
      signal = "sell";

   return signal;
}
