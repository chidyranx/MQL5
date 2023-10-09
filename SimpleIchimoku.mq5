void OnTick()
{
    // Create an array for the price data
    double TenkanSenArray[];

    // Define the Ichimoku EA
    int IchimokuDefinition = iIchimoku(_Symbol, _Period, 9, 26, 52);

    // Sort the prices from the current candle downwards
    ArraySetAsSeries(TenkanSenArray, true);

    // Defined EA, Tenkan-sen line, current candle, for 3 candles, store in array
    CopyBuffer(IchimokuDefinition, ICHIMOKU_TENKANSEN, 0, 3, TenkanSenArray);

    // Calculate the value for the current candle (Tenkan-sen line)
    double TenkanSenValue = TenkanSenArray[0];

    // Chart output
    Comment("Tenkan-sen Value: ", TenkanSenValue, "\n");
}
