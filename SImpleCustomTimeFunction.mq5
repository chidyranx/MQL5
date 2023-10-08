void OnTick()
{
    string myTime; // Create a string variable for custom time

    // Call custom function GetTime to calculate time
    myTime = GetTime();

    // Create a chart output for the time
    Comment(myTime);
}

string GetTime()
{
    string TimeWithSeconds; // Create a string for time with seconds

    // Calculate time with seconds for local time
    TimeWithSeconds = TimeToString(TimeLocal(), TIME_DATE | TIME_SECONDS);

    // Return calculated time to the main function
    return TimeWithSeconds;
}
