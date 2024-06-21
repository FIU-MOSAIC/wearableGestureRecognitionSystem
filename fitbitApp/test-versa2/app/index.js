/* const{ spawn } = require('child_process');

function fetchLog(){
    const fitbitLog = spawn('fitbit-cli',['fetch-logs']);

    fitbitLog.stdout.on('data', (data) => {
        console.log(`Accelerometer Data reciever: ${data}`);
    
    });
    fitbitLogs.stderr.on('data', (data) => {
        console.error(`Error: ${data}`);
    });
}
fetchLogs();
 */

import { Accelerometer } from "accelerometer";
import { outbox } from "file-transfer";
import { encode } from "cbor";

// Set up the accelerometer with higher frequency
const frequency = 50; // Adjust as needed (50Hz is often sufficient for tremor detection)
const accel = new Accelerometer({ frequency });

accel.addEventListener("reading", () => {
  const data = {
    x: accel.x,
    y: accel.y,
    z: accel.z,
    timestamp: Date.now()
  };

  // Send the data to the companion
  outbox.enqueue("accelerometer-data", encode(data)).catch((error) => {
    console.log(`Failed to send file: ${error}`);
  });
});

accel.start();