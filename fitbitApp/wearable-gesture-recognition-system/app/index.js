import * as document from "document";
import { Accelerometer } from "accelerometer";
import { Gyroscope } from "gyroscope";
import { HeartRateSensor } from "heart-rate";
import { OrientationSensor } from "orientation";
import { peerSocket } from "messaging";
import { Buffer } from "buffer";

const startButton = document.getElementById("start-button");
const stopButton = document.getElementById("stop-button");
const saveButton = document.getElementById("save");
const retryButton = document.getElementById("retry");
const centerText = document.getElementById("center-text");

let hasHardwareComponents;
let currentRun;

stopButton.style.display = "none";
saveButton.style.display = "none";
retryButton.style.display = "none";

startButton.addEventListener("click", () => {
    startButton.style.display = "none";
    hasHardwareComponents = Boolean(Accelerometer && Gyroscope && HeartRateSensor && OrientationSensor);

    if (!hasHardwareComponents) {
        centerText.text = "Device lacks required hardware to record exercises.";
    } else {
        recordRun();
    }
});

function recordRun() {
    stopButton.style.display = "inline";

    const freq = 5; // Frequency setter

    const accel = new Accelerometer({ frequency: freq });
    const gyro = new Gyroscope({ frequency: freq });
    const hrm = new HeartRateSensor();
    const orientation = new OrientationSensor({ frequency: freq });

    // Start sensors
    hrm.start();
    orientation.start();

    currentRun = {
        accelX: [],
        accelY: [],
        accelZ: [],
        gyroX: [],
        gyroY: [],
        gyroZ: [],
        heartRate: [],
        orientationAlpha: [],
        orientationBeta: [],
        orientationGamma: []
    };

    accel.addEventListener("reading", () => {
        currentRun.accelX.push(accel.x);
        currentRun.accelY.push(accel.y);
        currentRun.accelZ.push(accel.z);
    });

    gyro.addEventListener("reading", () => {
        currentRun.gyroX.push(gyro.x);
        currentRun.gyroY.push(gyro.y);
        currentRun.gyroZ.push(gyro.z);

        // Send combined data
        sendDataToCompanion(currentRun);
        currentRun = {
            accelX: [],
            accelY: [],
            accelZ: [],
            gyroX: [],
            gyroY: [],
            gyroZ: [],
            heartRate: [],
            orientationI: [],
            orientationJ: [],
            orientationK: []
        };
    });

    hrm.addEventListener("reading", () => {
        currentRun.heartRate.push(hrm.heartRate);
    });

    orientation.addEventListener("reading", () => {
        console.log(`Orientation Reading: timestamp=${orientation.timestamp}, 
            [${orientation.quaternion[0]}, ${orientation.quaternion[1]}, 
            ${orientation.quaternion[2]}, ${orientation.quaternion[3]}]`);

        currentRun.orientationI.push(orientation.quaternion[1]);
        currentRun.orientationJ.push(orientation.quaternion[2]);
        currentRun.orientationK.push(orientation.quaternion[3]);
    });

    accel.start();
    gyro.start();

    stopButton.addEventListener("click", () => {
        stopButton.style.display = "none";
        accel.stop();
        gyro.stop();
        hrm.stop();
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
    const encodedData = Buffer.from(JSON.stringify(data));
    if (peerSocket.readyState === peerSocket.OPEN) {
        peerSocket.send(encodedData);
        console.log("Sent data:", encodedData);
    } else {
        console.error("PeerSocket is not open");
    }
}
