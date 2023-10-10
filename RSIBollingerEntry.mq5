//+------------------------------------------------------------------+
//|                                                          RSI_BollingerBands.mq5                                      |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Your Name"
#property link      "https://www.example.com"
#property version   "1.0"
#property description "RSI and Bollinger Bands Example"

#include <Technical\Bollinger.mqh>

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
   return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   // Deinitialization code here
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
   // Empty chart output
   Comment("");

   // Arrays for RSI and Bollinger Bands
   double myRSIArray[], LowerBandArray[];

   // Define RSI settings
   int myRSIDefinition = iRSI(_Symbol, _Period, 14, PRICE_CLOSE);

   // Sort price data from the current candle downwards
   ArraySetAsSeries(myRSIArray, true);
   ArraySetAsSeries(LowerBandArray, true);

   // Copy RSI and Bollinger Bands data to arrays
   CopyBuffer(myRSIDefinition, 0, 0, 3, myRSIArray);
   int BollingerBandsDefinition = iBands(_Symbol, _Period, 20, 0, 2, PRICE_CLOSE);
   CopyBuffer(BollingerBandsDefinition, 2, 0, 3, LowerBandArray);

   // Get the ask price
   double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);

   // Get RSI and Lower Bollinger Band values for the current candle
   double myRSIValue = NormalizeDouble(myRSIArray[0], 2);
   double myLowerBandValue = LowerBandArray[1];

   // Check if RSI is below 30 and Ask is below the lower Bollinger Band
   if (myRSIValue < 30 && Ask < myLowerBandValue)
   {
      Comment("\n\n\n\n\n", "Market is oversold and below the lower Bollinger Band");
   }
}
