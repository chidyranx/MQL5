// Import Trade Library
#include<Trade\Trade.mqh>

// Create an instance of CTrade called trade
CTrade trade;

void OnTick()
{
   // Get the Ask price
   double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);

   // Get the Account Balance
   double Balance = AccountInfoDouble(ACCOUNT_BALANCE);

   // Get the Account Equity
   double Equity = AccountInfoDouble(ACCOUNT_EQUITY);

   // Open some buy positions to have something to close
   if (PositionsTotal() < 5)
   {
      trade.Buy(0.01, NULL, Ask, 0, (Ask + 100 * _Point), NULL);
   }

   // If we have a profit, close all positions
   if (Equity > Balance)
   {
      CloseAllPositions();
   }
}

void CloseAllPositions()
{
   // Iterate through positions and close them
   for (int i = PositionsTotal() - 1; i >= 0; i--)
   {
      // Get the ticket number for the current position
      ulong ticket = PositionGetTicket(i);

      // Close the current position
      trade.PositionClose(ticket);
   }
}
