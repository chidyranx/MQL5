void OnTick()
{
    // Create an empty string for the signal
    string signal = "";

    // Create arrays for several prices
    double myMovingAverageArray1[], myMovingAverageArray2[], myMovingAverageArray3[], myMovingAverageArray4[];

    // Define the properties of the Moving Averages
    int movingAverageDefinition1 = iMA(_Symbol, _Period, 50, 0, MODE_EMA, PRICE_CLOSE);
    int movingAverageDefinition2 = iMA(_Symbol, _Period, 100, 0, MODE_EMA, PRICE_CLOSE);
    int movingAverageDefinition3 = iMA(_Symbol, _Period, 150, 0, MODE_EMA, PRICE_CLOSE);
    int movingAverageDefinition4 = iMA(_Symbol, _Period, 200, 0, MODE_EMA, PRICE_CLOSE);

    // Sort the price arrays from the current candle downwards
    ArraySetAsSeries(myMovingAverageArray1, true);
    ArraySetAsSeries(myMovingAverageArray2, true);
    ArraySetAsSeries(myMovingAverageArray3, true);
    ArraySetAsSeries(myMovingAverageArray4, true);

    // Fill the arrays with data
    CopyBuffer(movingAverageDefinition1, 0, 0, 3, myMovingAverageArray1);
    CopyBuffer(movingAverageDefinition2, 0, 0, 3, myMovingAverageArray2);
    CopyBuffer(movingAverageDefinition3, 0, 0, 3, myMovingAverageArray3);
    CopyBuffer(movingAverageDefinition4, 0, 0, 3, myMovingAverageArray4);

    // Calculate moving average values for the current candle
    double myMovingAverageValue1 = myMovingAverageArray1[0];
    double myMovingAverageValue2 = myMovingAverageArray2[0];
    double myMovingAverageValue3 = myMovingAverageArray3[0];
    double myMovingAverageValue4 = myMovingAverageArray4[0];

    // Check for sell signal
    if (myMovingAverageValue1 < myMovingAverageValue2 &&
        myMovingAverageValue2 < myMovingAverageValue3 &&
        myMovingAverageValue3 < myMovingAverageValue4)
    {
        signal = "SELL";
    }

    // Check for buy signal
    if (myMovingAverageValue1 > myMovingAverageValue2 &&
        myMovingAverageValue2 > myMovingAverageValue3 &&
        myMovingAverageValue3 > myMovingAverageValue4)
    {
        signal = "BUY";
    }

    // Output the signal and moving average values
    Comment("Signal: ", signal, "\n",
            "myMovingAverageValue1: ", myMovingAverageValue1, "\n",
            "myMovingAverageValue2: ", myMovingAverageValue2, "\n",
            "myMovingAverageValue3: ", myMovingAverageValue3, "\n",
            "myMovingAverageValue4: ", myMovingAverageValue4, "\n");
}
