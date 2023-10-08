void OnTick()
{
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

    // Get the Bollinger Bands values for the current candle
    double myMiddleBandValue = middleBandArray[0];
    double myUpperBandValue = upperBandArray[0];
    double myLowerBandValue = lowerBandArray[0];

    // Chart output of the Bollinger Bands values
    Comment("myMiddleBandValue: ", myMiddleBandValue, "\n",
            "myUpperBandValue: ", myUpperBandValue, "\n",
            "myLowerBandValue: ", myLowerBandValue, "\n");
}
