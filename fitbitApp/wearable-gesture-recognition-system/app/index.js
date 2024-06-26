import * as document from "document";
import { Accelerometer } from "accelerometer";
import { Gyroscope } from "gyroscope";
import { OrientationSensor } from "orientation";
import { display } from "display";
import fs from 'fs';

// const elem = document.getElementById("myElem");
// elem.text = `x: y: z:`;

// if(Accelerometer){
//     console.log("this device has an accelerometer");
//     const acc = new Accelerometer({ frequency: 1 });

//     acc.addEventListener("reading", () => {
//         console.log(
//             `ts: ${acc.timestamp}, \
//             x: ${acc.x}, \
//             y: ${acc.y}, \
//             z: ${acc.z}`
//         );
//     });

//     display.addEventListener("change", () => {
//         if(display.on){
//             acc.start();
//         } else {
//             acc.stop();
//         }
//     });

//     acc.start();
// } else {
//     console.log("this device does not have an accelerometer");
// }

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

startButton.addEventListener("click", (evt) => {
    startButton.style.display = "none";
    hasHardwareComponents = Boolean(Accelerometer && Gyroscope && OrientationSensor);

    if(!(hasHardwareComponents)){
        centerText.text = "Device lacks required hardware to record exercises.";
    } else {
        recordRun();
    }
});

function recordRun(){
    stopButton.style.display = "inline";

    const freq = 1;
    const batchNum = freq * 2;

    const accel = new Accelerometer({ frequency: freq, batch: batchNum });
    const gyro = new Gyroscope({ frequency: freq, batch: batchNum });
    const orientation = new OrientationSensor({ frequency: freq, batch: batchNum });

    currentRun = {
        timestamps: [],
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
        for(let i = 0; i < accel.readings.timestamp.length; i++){
            currentRun.timestamps[i] = accel.readings.timestamp[i];
            currentRun.accelX[i] = accel.readings.x[i];
            currentRun.accelY[i] = accel.readings.y[i];
            currentRun.accelZ[i] = accel.readings.z[i];
        }
    });

    gyro.addEventListener("reading", () => {
        for(let i = 0; i < gyro.readings.timestamp.length; i++){
            currentRun.gyroX[i] = gyro.readings.x[i];
            currentRun.gyroY[i] = gyro.readings.y[i];
            currentRun.gyroZ[i] = gyro.readings.z[i];
        }
    });

    orientation.addEventListener("reading", () => {
        for(let i = 0; i < orientation.timestamp.length; i++){
            currentRun.orientationScalar[i] = orientation.readings.scalar[i];
            currentRun.orientationI[i] = orientation.readings.scalar[i];
            currentRun.orientationJ[i] = orientation.readings.scalar[i];
            currentRun.orientationK[i] = orientation.readings.scalar[i];
        }
    });

    accel.start();
    gyro.start();
    orientation.start();

    stopButton.addEventListener("click", (evt) => {
        stopButton.style.display = "none";

        accel.stop();
        gyro.stop();
        orientation.stop();

        resultsScreen();
    });
}

function resultsScreen(){
    saveButton.style.display = "inline";
    retryButton.style.display = "inline";

    saveButton.addEventListener("click", (evt) => {
        saveButton.style.display = "none";
        retryButton.style.display = "none";
        console.log(JSON.stringify(currentRun));
        fs.writeFile("run.json", currentRun, (err) => {

        });
        //upload results here
    });

    retryButton.addEventListener("click", (evt) => {
        saveButton.style.display = "none";
        retryButton.style.display = "none";
        recordRun();
    });
}
