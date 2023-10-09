void OnTick()
{
    Comment(""); // Empty chart output

    // Create an Array for several prices
    double myPriceArray0[];

    // Create an Array for several prices
    double myPriceArray1[];

    // Define the properties of the RVI EA
    int RVIDefinition = iRVI(_Symbol, _Period, 10);

    // Sort the price array from the current candle downwards
    ArraySetAsSeries(myPriceArray0, true);

    // Sort the price array from the current candle downwards
    ArraySetAsSeries(myPriceArray1, true);

    // Defined MA0, first line, current candle, 3 candles, store result
    CopyBuffer(RVIDefinition, 0, 0, 3, myPriceArray0);

    // Defined MA0, second line, current candle, 3 candles, store result
    CopyBuffer(RVIDefinition, 1, 0, 3, myPriceArray1);

    // Get the value of the current candle
    double RVIValue0 = (NormalizeDouble(myPriceArray0[0], 3));

    // Get the value of the current candle
    double RVIValue1 = (NormalizeDouble(myPriceArray1[0], 3));

    // Chart output

    // Main Trend
    if ((RVIValue0 < RVIValue1) && (RVIValue1 < 0))
        Comment("DOWN TREND");

    if ((RVIValue0 > RVIValue1) && (RVIValue0 > 0))
        Comment("UP TREND");

    // Correction
    if ((RVIValue0 > RVIValue1) && (RVIValue1 < 0))
        Comment("UP Correction");

    if ((RVIValue0 < RVIValue1) && (RVIValue0 > 0))
        Comment("DOWN CORRECTION");
}
