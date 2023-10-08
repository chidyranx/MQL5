void OnTick()
{
    // Create an array for storing prices
    double myPriceArray[];

    // Define the properties of the Force Index EA  
    int ForceIndexDefinition = iForce(_Symbol, _Period, 13, MODE_SMA, VOLUME_TICK);

    // Sort the price array from the current candle downwards
    ArraySetAsSeries(myPriceArray, true);
    
    // Calculate Force Index for the specified period
    CopyBuffer(ForceIndexDefinition, 0, 0, 3, myPriceArray);

    // Get the value of the current candle
    double ForceIndexValue = NormalizeDouble(myPriceArray[0], 6);

    // Output a comment depending on the Force Index value
    if (ForceIndexValue > 0) 
        Comment("Trending Upwards");
    else if (ForceIndexValue < 0) 
        Comment("Trending Downwards");
}
