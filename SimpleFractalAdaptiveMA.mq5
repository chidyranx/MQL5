void OnTick()
{
    // Create a string variable for the signal
    string signal = "";

    // Create a price array
    MqlRates PriceArray[];

    // Sort the price array from the current candle downwards
    ArraySetAsSeries(PriceArray, true);

    // Fill the price array with data for 3 candles
    int Data = CopyRates(Symbol(), Period(), 0, 3, PriceArray);

    // Create an array for the FRAMA
    double FramaArray[];

    // Define the FRAMA EA
    int FramaDefinition = iFrAMA(_Symbol, _Period, 14, 0, PRICE_CLOSE);

    // Sort the array from the current candle downwards
    ArraySetAsSeries(FramaArray, true);

    // Define EA, one line, from the current candle, for 3 candles, store in array
    CopyBuffer(FramaDefinition, 0, 0, 3, FramaArray);

    // Calculate the value for the last candle
    double FramaValue = FramaArray[1];

    // Sell if FRAMA value is above the last candle's high
    if (FramaValue > PriceArray[1].high)
    {
        signal = "Sell";
    }

    // Buy if FRAMA value is below the last candle's low 
    if (FramaValue < PriceArray[1].low)
    {
        signal = "Buy";
    }

    // Chart Output
    Comment("FRAMA Value: ", FramaValue, "\n", "Signal: ", signal);
}
