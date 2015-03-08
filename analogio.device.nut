// Read RSSI from IMP

/////////////////
// Phant Stuff //
/////////////////
const FIELD_COUNT = 1; // Number of fields in the stream
local fieldNames = ["rssi"]; // Exact names of each field

//Define functions
function push(){
    // Get rssi
    local rssi = imp.rssi();
    
    // Populate fieldData array with respective data values
    local fieldData = [rssi];

    // Create a data string to send to the agent. Should be of the form:
    // "fieldName0=fieldData0&fieldName1=fieldData1&fieldName2=fieldData2"
    local data = "";
    for (local i=0; i<FIELD_COUNT; i++)
    {
        data += fieldNames[i] + "=" + fieldData[i];
        if (i < FIELD_COUNT - 1) 
            data += "&";
    }
    agent.send("postData", data);
    imp.wakeup(10, push); //Wakeup every 10 seconds and read data.
}


//Begin executing program
push();          //Read RSSI