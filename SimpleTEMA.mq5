void OnTick()
{
    // Create a price array
    MqlRates PriceArray[];

    // Sort the array from the current candle downwards
    ArraySetAsSeries(PriceArray, true);

    // Fill the array with data for 3 candles
    int Data = CopyRates(_Symbol, _Period, 0, 3, PriceArray);

    // Create an array for the EA data
    double EAArray[];

    // Sort the array from the current candle downwards
    ArraySetAsSeries(EAArray, true);

    // Define the iTEMA EA
    int iTEMADefinition = iTEMA(_Symbol, _Period, 14, 0, PRICE_CLOSE);

    // Copy iTEMA values into the array
    CopyBuffer(iTEMADefinition, 0, 0, 3, EAArray);

    // Calculate the current iTEMA value
    double iTEMAVALUE = EAArray[0];

    // Create a chart output depending on the direction
    if (iTEMAVALUE > PriceArray[1].close)
        Comment("iTEMA IS SHORT ", "iTEMA Value: ", iTEMAVALUE);

    if (iTEMAVALUE < PriceArray[1].close)
        Comment("iTEMA IS LONG ", "iTEMA Value: ", iTEMAVALUE);
}
