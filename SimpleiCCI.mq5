void OnTick()
{
    // Create a string for the signal
    string signal = "";

    // Create an array for the price data
    double myPriceArray[];

    // Define the CCI EA
    int ICCIDefinition = iCCI(_Symbol, _Period, 14, PRICE_TYPICAL);

    // Sort the data from the current candle downwards
    ArraySetAsSeries(myPriceArray, true);

    // Defined EA, buffer 0, current candle, 3 candles, save in Array
    CopyBuffer(ICCIDefinition, 0, 0, 3, myPriceArray);

    // Calculate the value for the current candle
    double CCIValue = myPriceArray[0];

    // Sell signal
    if (CCIValue > 100)
        signal = "Sell";

    // Buy signal
    if (CCIValue < -100)
        signal = "Buy";

    // Chart output
    Comment("Signal: ", signal);
}
