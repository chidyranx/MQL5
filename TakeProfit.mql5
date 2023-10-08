#include <Trade\Trade.mqh>

CTrade trade;
input double MyTakeProfitValue = 20;

void OnTick()
{
    double Ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    double Balance = AccountBalance();
    double Equity = AccountEquity();

    if (Equity >= Balance)
    {
        double takeProfitPrice = Ask + MyTakeProfitValue * _Point;
        trade.Buy(0.10, NULL, Ask, 0, takeProfitPrice, NULL);
    }
}
