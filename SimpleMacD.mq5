void OnTick()
{
    // Create an array for several prices
    double myPriceArray[];

    // Define the properties of the MACD EA
    int MacDDefinition = iMACD(_Symbol, _Period, 12, 26, 9, PRICE_CLOSE);

    // Sort the price array from the current candle downwards
    ArraySetAsSeries(myPriceArray, true);

    // Copy MACD values into the array
    CopyBuffer(MacDDefinition, 0, 0, 3, myPriceArray);

    // Get the value of the current candle
    double MacDValue = myPriceArray[0];

    // Chart output depending on the value
    if (MacDValue > 0)
        Comment("Trending Upwards. MACD Value: ", MacDValue);

    if (MacDValue < 0)
        Comment("Trending Downwards. MACD Value: ", MacDValue);
}
