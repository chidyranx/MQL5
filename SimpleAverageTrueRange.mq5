void OnTick()
{
    // Create an array for ATR values
    double atrArray[];

    // Define the ATR indicator
    int atrDefinition = iATR(_Symbol, _Period, 14);

    // Sort the ATR array from the current candle downwards
    ArraySetAsSeries(atrArray, true);

    // Fill the array with ATR values
    CopyBuffer(atrDefinition, 0, 0, 3, atrArray);

    // Get the value of the current ATR
    double atrValue = NormalizeDouble(atrArray[0], 5);

    // Chart output depending on the value
    if (atrValue > 0.0024)
        Comment("STRONG Average True Range (ATR) Value: ", atrValue);
    else if (atrValue < 0.0014)
        Comment("WEAK Average True Range (ATR) Value: ", atrValue);
    else
        Comment("Average True Range (ATR) Value: ", atrValue);
}
