void OnTick()
{
   // Get the Ask price
   double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);

   // Create a label to display the Ask price
   ObjectCreate(_Symbol, "Label1", OBJ_LABEL, 0, 0, 0);

   // Set label properties
   ObjectSetString(0, "Label1", OBJPROP_FONT, "Arial");
   ObjectSetInteger(0, "Label1", OBJPROP_FONTSIZE, 24);
   ObjectSetString(_Symbol, "Label1", OBJPROP_TEXT, "Ask Price: " + StringFormat("%.5f", Ask));
   ObjectSetInteger(0, "Label1", OBJPROP_XDISTANCE, 5);
   ObjectSetInteger(0, "Label1", OBJPROP_YDISTANCE, 10);
}
