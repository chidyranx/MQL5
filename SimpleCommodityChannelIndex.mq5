void OnTick()
{
    // Create an array for CCI values
    double myCCIArr[];

    // Define the properties of the CCI EA
    int CCIDefinition = iCCI(_Symbol, _Period, 14, PRICE_CLOSE);

    // Sort the array from the current candle downwards
    ArraySetAsSeries(myCCIArr, true);

    // Copy CCI values into the array
    CopyBuffer(CCIDefinition, 0, 0, 3, myCCIArr);

    // Get the value of the current candle
    double CCIValue = myCCIArr[0];

    // Chart output depending on the value
    if (CCIValue > 100)
        Comment("OVERBOUGHT");
    else if (CCIValue < -100)
        Comment("OVERSOLD");
    else
        Comment("CCI is within a neutral range");
}
