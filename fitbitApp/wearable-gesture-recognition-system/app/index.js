import * as document from "document";
import { Accelerometer } from "accelerometer";
import { Gyroscope } from "gyroscope";
import { HeartRateSensor } from "heart-rate";
import { OrientationSensor } from "orientation";
import { peerSocket } from "messaging";
import { Buffer } from "buffer";

// get references to ui elements
const startButton = document.getElementById("start-button");
const stopButton = document.getElementById("stop-button");
const saveButton = document.getElementById("save");
const retryButton = document.getElementById("retry");
const centerText = document.getElementById("center-text");

let hasHardwareComponents;
let currentRun;

// initially hide some buttons
stopButton.style.display = "none";
saveButton.style.display = "none";
retryButton.style.display = "none";

// set up event listener for start button
startButton.addEventListener("click", () => {
    startButton.style.display = "none";
    hasHardwareComponents = Boolean(Accelerometer && Gyroscope && HeartRateSensor && OrientationSensor);

    if (!hasHardwareComponents) {
        centerText.text = "device lacks required hardware to record exercises.";
    } else {
        recordRun();
    }
});

// function to start recording run
function recordRun() {
    stopButton.style.display = "inline";

    const freq = 5; // frequency for sensors

    const accel = new Accelerometer({ frequency: freq });
    const gyro = new Gyroscope({ frequency: freq });
    const hrm = new HeartRateSensor();
    const orientation = new OrientationSensor({ frequency: freq });

    // start sensors
    hrm.start();
    orientation.start();

    // initialize data storage
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

    // event listeners for sensors
    accel.addEventListener("reading", () => {
        currentRun.accelX.push(accel.x);
        currentRun.accelY.push(accel.y);
        currentRun.accelZ.push(accel.z);
    });

    gyro.addEventListener("reading", () => {
        currentRun.gyroX.push(gyro.x);
        currentRun.gyroY.push(gyro.y);
        currentRun.gyroZ.push(gyro.z);

        // send combined data
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
        console.log(`orientation reading: timestamp=${orientation.timestamp}, 
            [${orientation.quaternion[0]}, ${orientation.quaternion[1]}, 
            ${orientation.quaternion[2]}, ${orientation.quaternion[3]}]`);

        currentRun.orientationI.push(orientation.quaternion[1]);
        currentRun.orientationJ.push(orientation.quaternion[2]);
        currentRun.orientationK.push(orientation.quaternion[3]);
    });

    accel.start();
    gyro.start();

    // set up event listener for stop button
    stopButton.addEventListener("click", () => {
        stopButton.style.display = "none";
        accel.stop();
        gyro.stop();
        hrm.stop();
        orientation.stop();
        resultsScreen();
    });
}

// function to display results screen
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

// function to send data to companion device
function sendDataToCompanion(data) {
    const encodedData = Buffer.from(JSON.stringify(data));
    if (peerSocket.readyState === peerSocket.OPEN) {
        peerSocket.send(encodedData);
        console.log("sent data:", encodedData);
    } else {
        console.error("peerSocket is not open");
    }
}
