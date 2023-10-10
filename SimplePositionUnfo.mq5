void OnTick()
{
   // If positions for this currency pair exist
   if (PositionSelect(_Symbol))
   {
      // Count down the number of positions until zero
      for(int i = PositionsTotal() - 1; i >= 0; i--) 
      {
         // Calculate the ticket number
         ulong PositionTicket = PositionGetTicket(i);
         
         // Calculate the currency pair 
         string PositionSymbol = PositionGetString(POSITION_SYMBOL); 
         
         // Calculate the open price for the position
         double PositionPriceOpen = PositionGetDouble(POSITION_PRICE_OPEN); 
         
         // Calculate the current position price
         double PositionPriceCurrent = PositionGetDouble(POSITION_PRICE_CURRENT);
         
         // Calculate the current position profit    
         double PositionProfit = PositionGetDouble(POSITION_PROFIT);
         
         // Calculate the current position swap
         int PositionSwap = (int)PositionGetDouble(POSITION_SWAP);  
         
         // Calculate the current position net profit
         double PositionNetProfit = PositionProfit + PositionSwap; 
         
         if (PositionSymbol == _Symbol)
         {    
            Comment(
               "Position Number: ", i, "\n", 
               "Position Ticket: ", PositionTicket, "\n",
               "Position Symbol: ", PositionSymbol, "\n",               
               "Position Profit: ", PositionProfit, "\n",
               "Position Swap: ", PositionSwap, "\n",
               "Position Net Profit: ", PositionNetProfit, "\n",               
               "Position Price Open: ", PositionPriceOpen, "\n",
               "Position Price Current: ", PositionPriceCurrent
            );
         } // if End               
      }  // for End
   }    // if End                                                                         
}
