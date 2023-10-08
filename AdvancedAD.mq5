string CheckEntry()
{
   // Create a string variable for the signal
   string signal = "";

   // Create an array for the price data
   double myPriceArray[];
      
   // Sort the array downwards from the current candle
   ArraySetAsSeries(myPriceArray, true);      

   // Define the IAD EA  
   int IADDefinition = iAD(_Symbol, _Period, VOLUME_TICK); 
      
   // EA Definition, one line, current candle, for 3 candles, save result in array
   CopyBuffer(IADDefinition, 0, 0, 3, myPriceArray);
      
   // Calculate the value for the current candle
   double IADValue = myPriceArray[0]; 
      
   // If the value is below 0
   if (IADValue < 0)
      signal = "Buy";
      
   // If the value is above 0
   if (IADValue > 0)
      signal = "Sell";

   // Return the signal to the main module
   return signal;            
}
