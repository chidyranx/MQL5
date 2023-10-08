string CheckEntry()
{
    // Create an array for the prices
    MqlRates PriceInfo[];

    // Sort the price array from the current candle downwards
    ArraySetAsSeries(PriceInfo, true);

    // Fill the array with the price data
    int PriceData = CopyRates(Symbol(), Period(), 0, Bars(Symbol(), Period()), PriceInfo);

    // Create a string variable for the signal
    string signal = "";

    // Create an array for AMA values
    double amaArray[];

    // Define the AMA indicator
    int amaDefinition = iAMA(_Symbol, _Period, 9, 2, 30, 0, PRICE_CLOSE);

    // Sort the AMA array from the current candle downwards
    ArraySetAsSeries(amaArray, true);

    // Fill the array with AMA values
    CopyBuffer(amaDefinition, 0, 0, 3, amaArray);

    // Get the value of the current AMA value
    double amaValue = NormalizeDouble(amaArray[0], _Digits);

    // Generate signals based on AMA values and closing price
    if (amaValue > PriceInfo[0].close)
    {
        signal = "sell";
    }
    else if (amaValue < PriceInfo[0].close)
    {
        signal = "buy";
    }

    // Return signal to main module
    return signal;
}
