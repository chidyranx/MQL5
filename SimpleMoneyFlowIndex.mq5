void OnTick()
{
    // Create an array for MFI values
    double mfiArray[];

    // Define the MFI indicator
    int mfiDefinition = iMFI(_Symbol, _Period, 14, VOLUME_TICK);

    // Sort the MFI array from the current candle downwards
    ArraySetAsSeries(mfiArray, true);

    // Fill the array with MFI values
    CopyBuffer(mfiDefinition, 0, 0, 3, mfiArray);

    // Get the value of the current MFI
    double mfiValue = NormalizeDouble(mfiArray[0], 2);

    // Chart output depending on the value
    if (mfiValue > 80)
        Comment("Money Flow Index (MFI) is OVERBOUGHT: ", mfiValue);
    else if (mfiValue < 20)
        Comment("Money Flow Index (MFI) is OVERSOLD: ", mfiValue);
    else
        Comment("Money Flow Index (MFI): ", mfiValue);
}
