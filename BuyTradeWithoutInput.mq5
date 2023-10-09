#include <Trade\Trade.mqh>

CTrade trade;
input double MyLotSize = 0.10;

void OnTick()
{
   double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
   double Balance = AccountInfoDouble(ACCOUNT_BALANCE);
   double Equity = AccountInfoDouble(ACCOUNT_EQUITY);

   // Check if there are no open positions and no pending orders
   if (PositionsTotal() == 0 && OrdersTotal() == 0)
   {
      // Check if equity is greater than or equal to balance
      if (Equity >= Balance)
      {
         // Place a buy order
         trade.Buy(MyLotSize, NULL, Ask, 0, (Ask + 100 * _Point), NULL);
      }
   }
}
