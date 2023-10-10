void OnTick()
{
    MqlRates priceData[]; // Create a price array

    // Sort the array from the current candle downwards
    ArraySetAsSeries(priceData, true);

    // Copy candle prices for 3 candles into array
    CopyRates(_Symbol, _Period, 0, 3, priceData);

    // Create a counter for the candle
    static int candleCounter = 0;

    // Create Datetime variable for the last time stamp
    static datetime timeStampLastCheck = 0;

    // Read time stamp for current candle in array
    datetime timeStampCurrentCandle = priceData[0].time;

    // If the current time stamp is different from last time
    if (timeStampCurrentCandle != timeStampLastCheck)
    {
        // Remember current timestamp for next time
        timeStampLastCheck = timeStampCurrentCandle;

        // Add 1 to the candleCounter
        candleCounter = candleCounter + 1;
    }

    // Chart output
    Comment("Counted candles since start: ", candleCounter);
}
