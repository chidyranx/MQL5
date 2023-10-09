void OnTick()
{
    // Create an array for the BWMFI values
    double BWMFIArray[];
    
    // Define the BWMFI EA
    int BWMFIDefinition = iBWMFI(_Symbol, _Period, VOLUME_TICK);
    
    // Sort the array from the current candle downwards
    ArraySetAsSeries(BWMFIArray, true);
    
    // Retrieve BWMFI values for the current and previous 3 candles
    CopyBuffer(BWMFIDefinition, 0, 0, 4, BWMFIArray);
    
    // Calculate the value for the current candle
    double BWMFIValue = NormalizeDouble(BWMFIArray[0], 5);
    
    // Chart output
    Comment("BWMFIValue: ", BWMFIValue);
}
