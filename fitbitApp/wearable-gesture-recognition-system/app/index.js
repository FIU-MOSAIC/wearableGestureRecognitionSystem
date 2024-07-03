import * as document from "document";
import { Accelerometer } from "accelerometer";
import { Gyroscope } from "gyroscope";
import { OrientationSensor } from "orientation";
import { outbox } from "file-transfer";
import { encode } from "cbor";

const startButton = document.getElementById("start-button");
const stopButton = document.getElementById("stop-button");
const saveButton = document.getElementById("save");
const retryButton = document.getElementById("retry");
const centerText = document.getElementById("center-text");

let hasHardwareComponents;
let currentRun;
let dataTransferInterval;

stopButton.style.display = "none";
saveButton.style.display = "none";
retryButton.style.display = "none";

startButton.addEventListener("click", () => {
    startButton.style.display = "none";
    hasHardwareComponents = Boolean(Accelerometer && Gyroscope && OrientationSensor);

    if (!hasHardwareComponents) {
        centerText.text = "Device lacks required hardware to record exercises.";
    } else {
        recordRun();
    }
});

function recordRun() {
    stopButton.style.display = "inline";

    const freq = 1;
    const batchNum = freq;

    const accel = new Accelerometer({ frequency: freq, batch: batchNum });
    const gyro = new Gyroscope({ frequency: freq, batch: batchNum });
    const orientation = new OrientationSensor({ frequency: freq, batch: batchNum });

    currentRun = {
        accelX: [],
        accelY: [],
        accelZ: [],
        gyroX: [],
        gyroY: [],
        gyroZ: [],
        orientationScalar: [],
        orientationI: [],
        orientationJ: [],
        orientationK: []
    };

    accel.addEventListener("reading", () => {
        for (let i = 0; i < accel.readings.timestamp.length; i++) {
            currentRun.accelX.push(accel.readings.x[i]);
            currentRun.accelY.push(accel.readings.y[i]);
            currentRun.accelZ.push(accel.readings.z[i]);
        }
    });

    gyro.addEventListener("reading", () => {
        for (let i = 0; i < gyro.readings.timestamp.length; i++) {
            currentRun.gyroX.push(gyro.readings.x[i]);
            currentRun.gyroY.push(gyro.readings.y[i]);
            currentRun.gyroZ.push(gyro.readings.z[i]);
        }
    });

    orientation.addEventListener("reading", () => {
        for (let i = 0; i < orientation.readings.timestamp.length; i++) {
            currentRun.orientationScalar.push(orientation.readings.scalar[i]);
            currentRun.orientationI.push(orientation.readings.i[i]);
            currentRun.orientationJ.push(orientation.readings.j[i]);
            currentRun.orientationK.push(orientation.readings.k[i]);
        }
    });

    accel.start();
    gyro.start();
    orientation.start();

    // Set an interval to send data every second
    dataTransferInterval = setInterval(() => {
        sendDataToCompanion(currentRun);
        currentRun = { accelX: [], accelY: [], accelZ: [], gyroX: [], gyroY: [], gyroZ: [], orientationScalar: [], orientationI: [], orientationJ: [], orientationK: [] };
    }, 4000);//hereeeeeeeeeeeeee
    //hereeeeeeeeeee

    stopButton.addEventListener("click", () => {
        stopButton.style.display = "none";
        clearInterval(dataTransferInterval);

        accel.stop();
        gyro.stop();
        orientation.stop();

        resultsScreen();
    });
}

function resultsScreen() {
    saveButton.style.display = "inline";
    retryButton.style.display = "inline";

    saveButton.addEventListener("click", () => {
        saveButton.style.display = "none";
        retryButton.style.display = "none";
        sendDataToCompanion(currentRun);
    });

    retryButton.addEventListener("click", () => {
        saveButton.style.display = "none";
        retryButton.style.display = "none";
        recordRun();
    });
}

function sendDataToCompanion(data) {
    const encodedData = encode(data);
    outbox.enqueue("sensorData.cbor", encodedData)
        .then(ft => {
            console.log("Data transfer queued:", ft.name);
        })
        .catch(error => {
            console.error("Error queueing data transfer:", error);
        });
}
