void OnTick()
{
   // Array for prices
   MqlRates PriceInformation[];

   // Sort array downwards from the current candle
   ArraySetAsSeries(PriceInformation, true);

   // Copy price data into the array
   int Data = CopyRates(Symbol(), Period(), 0, Bars(Symbol(), Period()), PriceInformation);

   // Static counter
   static int i;

   // Create an arrow named MyArrow
   ObjectCreate(_Symbol, "MyArrow", OBJ_ARROW, 0, TimeCurrent(), (PriceInformation[0].high));

   // Set the Arrowcode for the object
   ObjectSetInteger(0, "MyArrow", OBJPROP_ARROWCODE, i);

   // Set the color for the object (clrGreen represents green color)
   ObjectSetInteger(0, "MyArrow", OBJPROP_COLOR, clrGreen);

   // Set the size for the object
   ObjectSetInteger(0, "MyArrow", OBJPROP_WIDTH, 20);

   // Move the object to the current candle high
   ObjectMove(_Symbol, "MyArrow", 0, TimeCurrent(), (PriceInformation[0].high));

   // Chart output for the current counter value
   Comment("i has the value: ", i);

   // Increase counter by 1
   i++;
}
