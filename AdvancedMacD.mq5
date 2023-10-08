string CheckEntry()
{
    // Create a string variable for the signal
    string signal = "";

    // Create an array for MACD values
    double macdArray[];

    // Define the MACD indicator
    int macdDefinition = iMACD(_Symbol, _Period, 12, 26, 9, PRICE_CLOSE);

    // Sort the MACD array from the current candle downwards
    ArraySetAsSeries(macdArray, true);

    // Fill the array with MACD values
    CopyBuffer(macdDefinition, 0, 0, 3, macdArray);

    // Get the value of the current MACD value
    double macdValue = macdArray[0];

    // Generate signals based on MACD values
    if (macdValue > 0)
    {
        signal = "sell";
    }
    else if (macdValue < 0)
    {
        signal = "buy";
    }

    return signal;
}
