import { inbox } from "file-transfer";
import { decode } from "cbor";

function processAllFiles() {
  let file;
  while (file = inbox.nextFile()) {
    const data = decode(file);
    const filteredData = filter(data.x, data.y, data.z); // Apply the filter to the accelerometer data

    console.log(`Filtered Accelerometer data: ${JSON.stringify(filteredData)}`);
  }
}

inbox.addEventListener("newfile", processAllFiles);
processAllFiles();