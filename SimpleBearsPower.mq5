void OnTick()
{
    // Create an array for Bears Power values
    double bearsPowerArray[];

    // Define the Bears Power indicator
    int bearsPowerDefinition = iBearsPower(_Symbol, _Period, 13);

    // Sort the Bears Power array from the current candle downwards
    ArraySetAsSeries(bearsPowerArray, true);

    // Fill the array with Bears Power values
    CopyBuffer(bearsPowerDefinition, 0, 0, 3, bearsPowerArray);

    // Get the value of the current Bears Power
    double bearsPowerValue = bearsPowerArray[0];

    // Print the Bears Power value on the chart
    Comment("Bears Power Value: ", bearsPowerValue);
}
