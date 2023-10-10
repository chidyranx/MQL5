void OnTick()
{
    int PositionsForThisCurrencyPair = 0; // Local position count variable

    for (int i = PositionsTotal() - 1; i >= 0; i--) // Count all currency pair positions
    {
        string symbol = PositionGetSymbol(i); // Get position currency pair symbol

        if (Symbol() == symbol) // If chart symbol equals position symbol
        {
            PositionsForThisCurrencyPair += 1; // Add 1 to counter
        }
    } // End of for loop

    Comment("\n\nPositions For this currency pair: ", PositionsForThisCurrencyPair); // Chart text output
}
