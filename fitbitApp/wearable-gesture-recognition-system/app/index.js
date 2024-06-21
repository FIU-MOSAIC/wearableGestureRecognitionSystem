import * as document from "document";
import { Accelerometer } from "accelerometer";
import { Gyroscope } from "gyroscope";
import { OrientationSensor } from "orientation";
import { display } from "display";

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

stopButton.style.display = "none";
saveButton.style.display = "none";
retryButton.style.display = "none";

startButton.addEventListener("click", (evt) => {
    startButton.style.display = "none";
    hasHardwareComponents = Boolean(Accelerometer && Gyroscope && OrientationSensor);

    if(!(hasHardwareComponents)){
        centerText.text = "Device lacks required hardware to record exercises.";
    } else {
        recordRun(stopButton);
    }
});

function recordRun(){
    stopButton.style.display = "inline";

    const freq = 1;

    const accel = Accelerometer({ frequency: freq});
    const gyro = Gyroscope({ frequency: freq});
    const orientation = OrientationSensor({ frequency: freq});

    stopButton.addEventListener("click", (evt) => {
        stopButton.style.display = "none";
        resultsScreen();
    });
}

function resultsScreen(){
    saveButton.style.display = "inline";
    retryButton.style.display = "inline";

    retryButton.addEventListener("click", (evt) => {
        saveButton.style.display = "none";
        retryButton.style.display = "none";
        recordRun();
    });
}
