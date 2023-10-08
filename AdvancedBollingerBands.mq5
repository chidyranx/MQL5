string CheckEntry()
{
    // Create an array for the prices
    MqlRates PriceInfo[];

    // Sort the price array from the current candle downwards
    ArraySetAsSeries(PriceInfo, true);

    // Fill the array with the price data
    int data = CopyRates(Symbol(), Period(), 0, Bars(Symbol(), Period()), PriceInfo);

    // Create a string variable for the signal
    string signal = "";

    // Create arrays for Bollinger Bands values
    double middleBandArray[];
    double upperBandArray[];
    double lowerBandArray[];

    // Sort the arrays from the current candle downwards
    ArraySetAsSeries(middleBandArray, true);
    ArraySetAsSeries(upperBandArray, true);
    ArraySetAsSeries(lowerBandArray, true);

    // Define Bollinger Bands
    int bollingerBandsDefinition = iBands(_Symbol, _Period, 20, 0, 2, PRICE_CLOSE);

    // Copy Bollinger Bands values into the arrays
    CopyBuffer(bollingerBandsDefinition, 0, 0, 3, middleBandArray);
    CopyBuffer(bollingerBandsDefinition, 1, 0, 3, upperBandArray);
    CopyBuffer(bollingerBandsDefinition, 2, 0, 3, lowerBandArray);

    // Calculate Bollinger Bands values for the last and the candle before
    double myMiddleBandValue0 = middleBandArray[0];
    double myUpperBandValue0 = upperBandArray[0];
    double myLowerBandValue0 = lowerBandArray[0];

    double myMiddleBandValue1 = middleBandArray[1];
    double myUpperBandValue1 = upperBandArray[1];
    double myLowerBandValue1 = lowerBandArray[1];

    // Buy signal
    if (PriceInfo[1].close < myLowerBandValue1 && PriceInfo[0].close > myLowerBandValue0)
        signal = "buy";

    // Sell signal
    if (PriceInfo[1].close > myUpperBandValue1 && PriceInfo[0].close < myUpperBandValue0)
        signal = "sell";

    return signal;
}
