void OnTick()
{
    // Create an Array for several prices
    double myPriceArray[];

    // Define the properties of the Momentum EA
    int iMomentumDefinition = iMomentum(_Symbol, _Period, 14, PRICE_CLOSE);

    // Sort the price array from the current candle downwards
    ArraySetAsSeries(myPriceArray, true);

    // Defined Momentum, current candle, 3 candles, store result
    CopyBuffer(iMomentumDefinition, 0, 0, 3, myPriceArray);

    // Get the value of the current candle
    double myMomentumValue = NormalizeDouble(myPriceArray[0], 2);

    // Chart output depending on the value
    if (myMomentumValue > 100.0)
        Comment("STRONG MOMENTUM: ", myMomentumValue);
    else if (myMomentumValue < 99.9)
        Comment("WEAK MOMENTUM: ", myMomentumValue);
    else
        Comment(" ", myMomentumValue);
}
