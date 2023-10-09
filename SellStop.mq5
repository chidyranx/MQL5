#include <Trade\Trade.mqh>
CTrade trade;

void OnTick()
{
    // Get the Bid price
    double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);

    // Get the account balance
    double Balance = AccountInfoDouble(ACCOUNT_BALANCE);

    // Get the account equity
    double Equity = AccountInfoDouble(ACCOUNT_EQUITY);

    // If we have no open positions and no orders
    if (PositionsTotal() == 0 && OrdersTotal() == 0)
    {
        // Sell stop, 10 microlots, 100 points below Bid, no SL,
        // 300 points TP, no expiration, no date, no comment
        trade.SellStop(0.10, Bid - 100 * _Point, _Symbol, 0, Bid - 300 * _Point, ORDER_TIME_GTC, 0, 0);
    }

    Comment("Balance: ", Balance, " Equity: ", Equity);
}
