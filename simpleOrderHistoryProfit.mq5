#include<Trade\Trade.mqh>

// Create an instance of CTrade called trade
CTrade trade;

void OnTick()
{
    // Calculate the Ask price
    double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);

    // Calculate the Bid price
    double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);

    // Check if there are no open positions
    if (PositionsTotal() < 1)
    {
        // Open a buy trade
        trade.Buy(0.10, NULL, Ask, 0, (Ask + 150 * _Point), NULL);

        // Open a sell trade
        trade.Sell(0.10, NULL, Bid, 0, (Bid - 150 * _Point), NULL);
    }

    // Calculate the last profit
    string MyLastProfit = GetLastProfit();

    // Create a chart output
    Comment("My last profit was: ", "\n", MyLastProfit);
}

string GetLastProfit()
{
    uint TotalNumberOfDeals = HistoryDealsTotal();
    ulong TicketNumber = 0;
    long OrderType, DealEntry;
    double OrderProfit = 0;
    string MySymbol = "";
    string PositionDirection = "";
    string MyResult = "";

    // Get the history
    HistorySelect(0, TimeCurrent());

    // Iterate through all the deals
    for (uint i = 0; i < TotalNumberOfDeals; i++)
    {
        // Check if a ticket number is available
        if ((TicketNumber = HistoryDealGetTicket(i)) > 0)
        {
            // Get the profit
            OrderProfit = HistoryDealGetDouble(TicketNumber, DEAL_PROFIT);

            // Get the order type
            OrderType = HistoryDealGetInteger(TicketNumber, DEAL_TYPE);

            // Check if the currency pair matches
            MySymbol = HistoryDealGetString(TicketNumber, DEAL_SYMBOL);

            // Get the deal entry type to check for close types
            DealEntry = HistoryDealGetInteger(TicketNumber, DEAL_ENTRY);

            // Check if the currency pair matches and the deal was closed
            if (MySymbol == _Symbol && (OrderType == ORDER_TYPE_BUY || OrderType == ORDER_TYPE_SELL) && DealEntry == 1)
            {
                // Determine the position direction based on order type
                if (OrderType == ORDER_TYPE_BUY)
                    PositionDirection = "SELL-TRADE";
                else if (OrderType == ORDER_TYPE_SELL)
                    PositionDirection = "BUY-TRADE";

                // Format the result string
                MyResult = "Profit:" + OrderProfit + " Ticket:" + TicketNumber + " Position Direction:" + PositionDirection;
            }
        }
    }

    // Return the result
    return MyResult;
}
