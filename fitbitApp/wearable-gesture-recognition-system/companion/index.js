import { inbox } from "file-transfer";
import { me as companion } from "companion";

companion.wakeInterval = 300000; // Check every 5 minutes

async function processAllFiles() {
    let file;
    while ((file = await inbox.pop())) {
        console.log(`Received new file: ${file.name}`);
        try {
            const data = await file.cbor();
            console.log("Data read from file:", data);
            sendDataToServer(data);
        } catch (error) {
            console.error("Error reading file:", error);
        }
    }
}

inbox.addEventListener("newfile", processAllFiles);
processAllFiles();

function sendDataToServer(data) {
    try {
        const jsonData = JSON.stringify(data);
        console.log("Sending data to server:", jsonData);
        fetch('http://192.168.0.13:8083/data', { //IP and endpoint
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: jsonData
        })
        .then(response => response.json())
        .then(responseData => {
            console.log("Data sent successfully:", responseData);
        })
        .catch(error => {
            console.error("Error sending data:", error);
        });
    } catch (error) {
        console.error("Error encoding data:", error);
    }
}
