void OnTick()
{
   // Create variable for highest candle
   int HighestCandle; 
   
   // Create Arrays for highest candle and prices
   double High[];
   MqlRates PriceInformation[];  

   // Sort array downwards from the current candle   
   ArraySetAsSeries(High, true);
   ArraySetAsSeries(PriceInformation, true);

   // Fill array with high data for 100 candles
   CopyHigh(_Symbol, _Period, 0, 100, High);   

   // Calculate the highest candle
   HighestCandle = ArrayMaximum(High, 0, 100);
  
   // Copy price data into the array
   int Data = CopyRates(Symbol(), Period(), 0, Bars(Symbol(), Period()), PriceInformation);  
    
   // Draw a horizontal line at the highest high
   double highestHigh = PriceInformation[HighestCandle].high;
   ObjectCreate(_Symbol, "Line1", OBJ_HLINE, 0, 0, highestHigh);
   
   // Set line properties
   ObjectSetInteger(0, "Line1", OBJPROP_COLOR, clrRed);
   ObjectSetInteger(0, "Line1", OBJPROP_WIDTH, 3);
   
   // Move the line
   ObjectMove(_Symbol, "Line1", 0, 0, highestHigh); 
}
