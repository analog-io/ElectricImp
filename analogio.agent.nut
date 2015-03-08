/*****************************************************************
Phant Imp (Agent)
Post data to SparkFun's data stream server system (phant) using
an Electric Imp
Jim Lindblom @ SparkFun Electronics
Original Creation Date: July 7, 2014
Modified for AnalogIO on March 7, 2015

Description

Before uploading this sketch, there are a number of vars that need adjusting:
1. Phant Stuff: Fill in your data stream's public, private, and 
data keys before uploading!

This code is beerware; if you see me (or any other SparkFun 
employee) at the local, and you've found our code helpful, please 
buy us a round!

Distributed as-is; no warranty is given.
*****************************************************************/

/////////////////
// Phant Stuff //
/////////////////
local publicKey = "YOUR PUBLIC KEY"; // Your Phant public key
local privateKey = "YOUR PRIVATE KEY"; // The Phant private key
local phantServer = "data.sparkfun.com"; // Your Phant server, base URL, no HTTP

/////////////////////
// postData Action //
/////////////////////
// When the agent receives a "postData" string from the device, use the
// dataString string to construct a HTTP POST, and send it to the server.
device.on("postData", function(dataString) {

    server.log("Sending " + dataString); // Print a debug message

    // Construct the base URL: https://data.sparkfun.com/input/PUBLIC_KEY:
    local phantURL = "https://" +  phantServer + "/input/" + publicKey;
    // Construct the headers: e.g. "Phant-Priave-Key: PRIVATE_KEY"
    local phantHeaders = {"Phant-Private-Key": privateKey, "connection": "close"};
    // Send the POST to phantURL, with phantHeaders, and dataString data.
    local request = http.post(phantURL, phantHeaders, dataString);

    // Get the response from the server, and send it out the debug window:
    local response = request.sendsync();
    server.log("Phant response: " + response.body);
});