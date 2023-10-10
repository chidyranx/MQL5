void OnTick()
{
    // Create an array for RSI values
    double myRSIArray[];

    // Define the properties of the RSI
    int myRSIDefinition = iRSI(_Symbol, _Period, 14, PRICE_CLOSE);

    // Sort the price array from the current candle downwards
    ArraySetAsSeries(myRSIArray, true);

    // Copy RSI data into the array
    CopyBuffer(myRSIDefinition, 0, 0, 3, myRSIArray);

    // Calculate RSI value for the current candle
    double myRSIValue = NormalizeDouble(myRSIArray[0], 2);

    // Chart output of the current RSI value
    Comment("myRSIValue: ", myRSIValue);
}
