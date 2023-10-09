#include <Trade\Trade.mqh>

CTrade trade;

void OnTick()
{
   // Get the account balance
   double Balance = AccountInfoDouble(ACCOUNT_BALANCE);
   
   // Get the account equity
   double Equity = AccountInfoDouble(ACCOUNT_EQUITY);
  
   // Get the Ask price
   double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
   
   // Get the Bid price
   double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
  
   // If we have no open positions and no orders
   if (PositionsTotal() == 0 && OrdersTotal() == 0)
   {
     Print("### PositionsTotal: ", PositionsTotal(), " OrdersTotal: ", OrdersTotal());
     // Buy stop, 10 microlots, 100 points above Ask, no SL, 
     // 300 points TP, no expiration, no date, no comment
     trade.BuyStop(0.10, Ask + 100 * _Point, _Symbol, 0, Ask + 300 * _Point, ORDER_TIME_GTC, 0, 0);
     
     // Sell stop, 10 microlots, 100 points below Bid, no SL, 
     // 300 points TP, no expiration, no date, no comment
     trade.SellStop(0.10, Bid - 100 * _Point, _Symbol, 0, Bid - 200 * _Point, ORDER_TIME_GTC, 0, 0);
   }
   
   // If we have at least 1 position
   if (Balance != Equity) 
      CancelOrders();   
}

void CancelOrders()
{
    // Check all orders 
    for (int i = OrdersTotal() - 1; i >= 0; i--)
    {
        // Get the ticket number 
        ulong OrderTicket = OrderGetTicket(i);

        // Delete the pending orders
        trade.OrderDelete(OrderTicket);
    }
}
