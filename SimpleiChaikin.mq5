void OnTick()
{
    // String variable for signal
    string signal = "";

    // Create an array for several prices
    double myPriceArray[];

    // Define the properties of the Chaikin EA  
    int ChaikinDefinition = iChaikin(_Symbol, _Period, 3, 10, MODE_EMA, VOLUME_TICK);

    // Sort the price array from the current candle downwards
    ArraySetAsSeries(myPriceArray, true);

    // Calculate the Chaikin Oscillator values
    CopyBuffer(ChaikinDefinition, 0, 0, 3, myPriceArray);

    // Get the value of the current candle
    double ChaikinValue = myPriceArray[0];

    // Get the value of the last candle
    double PreviousChaikinValue = myPriceArray[1];

    // Buy if crossed zero line from below
    if (ChaikinValue > 0 && PreviousChaikinValue < 0)
    {
        signal = "buy";
    }
    
    // Sell if crossed zero line from above
    if (ChaikinValue < 0 && PreviousChaikinValue > 0)
    {
        signal = "sell";
    }

    // Display the Chaikin Oscillator value and signal on the chart
    Comment("ChaikinValue: ", ChaikinValue, "\n", "Signal: ", signal);
}
