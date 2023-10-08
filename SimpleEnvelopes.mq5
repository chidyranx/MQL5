void OnTick()
{
    // Create an array for storing price data
    MqlRates PriceInformation[];

    // Sort the array from the current candle to the oldest
    ArraySetAsSeries(PriceInformation, true);

    // Copy price data into the array
    int Data = CopyRates(Symbol(), Period(), 0, Bars(Symbol(), Period()), PriceInformation);

    // Create arrays for the Upper and Lower Envelopes bands
    double UpperBandArray[];
    double LowerBandArray[];

    // Sort the arrays from the current candle downwards
    ArraySetAsSeries(UpperBandArray, true);
    ArraySetAsSeries(LowerBandArray, true);

    // Define Envelopes 
    int EnvelopesDefinition = iEnvelopes(_Symbol, _Period, 14, 0, MODE_SMA, PRICE_CLOSE, 0.100);

    // Copy price info into the arrays
    CopyBuffer(EnvelopesDefinition, 0, 0, 3, UpperBandArray);
    CopyBuffer(EnvelopesDefinition, 1, 0, 3, LowerBandArray); 

    // Calculate values for the current candle
    double myUpperBandValue = NormalizeDouble(UpperBandArray[0], 6);
    double myLowerBandValue = NormalizeDouble(LowerBandArray[0], 6);   

    // Chart output of the current EA
    if (PriceInformation[1].close > myUpperBandValue)
        Comment("UPPER SIGNAL");

    if (PriceInformation[1].close < myLowerBandValue)
        Comment("LOWER SIGNAL");    

    if ((PriceInformation[1].close < myUpperBandValue) &&   
        (PriceInformation[1].close > myLowerBandValue)) 
    {
        Comment("myUpperBandValue: ", myUpperBandValue, "\n",
                "myLowerBandValue: ", myLowerBandValue, "\n");
    }
}
