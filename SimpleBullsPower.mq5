void OnTick()
{
    // Create an array for Bulls Power values
    double bullsPowerArray[];

    // Define the Bulls Power indicator
    int bullsPowerDefinition = iBullsPower(_Symbol, _Period, 13);

    // Sort the Bulls Power array from the current candle downwards
    ArraySetAsSeries(bullsPowerArray, true);

    // Fill the array with Bulls Power values
    CopyBuffer(bullsPowerDefinition, 0, 0, 3, bullsPowerArray);

    // Get the value of the current Bulls Power
    double bullsPowerValue = bullsPowerArray[0];

    // Print the Bulls Power value on the chart
    Comment("Bulls Power Value: ", bullsPowerValue);
}
