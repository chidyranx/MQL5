void OnTick()
{
    // Create an array for the iTriX values
    double myPriceArray[];

    // Define the properties of the iTriX EA
    int iTriXDefinition = iTriX(_Symbol, _Period, 14, PRICE_CLOSE);

    // Sort the array from the current candle downwards
    ArraySetAsSeries(myPriceArray, true);

    // Copy iTriX values into the array
    CopyBuffer(iTriXDefinition, 0, 0, 3, myPriceArray);

    // Get the value of the current candle
    float iTriXValue = myPriceArray[0];

    // Display a comment based on the iTriX value
    if (iTriXValue > 0)
        Comment("iTriX IS LONG ", iTriXValue);

    if (iTriXValue < 0)
        Comment("iTriX IS SHORT ", iTriXValue);
}
