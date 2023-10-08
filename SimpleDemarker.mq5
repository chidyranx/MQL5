void OnTick()
{
    double myPriceArray[]; // Create an Array for price information

    int DemmarkerDefinition = iDeMarker(_Symbol, _Period, 14); // Define DeMarker properties

    ArraySetAsSeries(myPriceArray, true); // Sort the array from current candle to oldest candle

    CopyBuffer(DemmarkerDefinition, 0, 0, 3, myPriceArray); // Copy DeMarker values into the array

    double DemmarkerValue = myPriceArray[0]; // Get the value of the current candle

    // Check DeMarker value and output messages
    if (DemmarkerValue > 0.7)
        Comment("STRONG TREND");

    if (DemmarkerValue < 0.3)
        Comment("WEAK TREND");

    if ((DemmarkerValue > 0.3) && (DemmarkerValue < 0.7))
        Comment(""); // No specific message for values between 0.3 and 0.7
}
