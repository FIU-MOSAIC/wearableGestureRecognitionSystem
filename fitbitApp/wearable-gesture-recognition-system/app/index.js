import * as document from "document";
import { Accelerometer } from "accelerometer";
import { Gyroscope } from "gyroscope";
import { OrientationSensor } from "orientation";
import { messaging } from "messaging";

const startButton = document.getElementById("start-button");
const stopButton = document.getElementById("stop-button");
const centerText = document.getElementById("center-text");

let hasHardwareComponents;
let currentRun = {
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

function recordRun() {
  const freq = 1;
  const batchNum = freq * 2;

  const accel = new Accelerometer({ frequency: freq, batch: batchNum });
  const gyro = new Gyroscope({ frequency: freq, batch: batchNum });
  const orientation = new OrientationSensor({ frequency: freq, batch: batchNum });

  accel.addEventListener("reading", () => {
    for (let i = 0; i < accel.readings.timestamp.length; i++) {
      currentRun.timestamps.push(accel.readings.timestamp[i]);
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
      currentRun.orientationI.push(orientation.readings.scalar[i]);
      currentRun.orientationJ.push(orientation.readings.scalar[i]);
      currentRun.orientationK.push(orientation.readings.scalar[i]);
    }
  });

  accel.start();
  gyro.start();
  orientation.start();

  stopButton.style.display = "inline";
  stopButton.addEventListener("click", () => {
    stopButton.style.display = "none";
    accel.stop();
    gyro.stop();
    orientation.stop();
    sendDataToCompanion();
  });
}

function sendDataToCompanion() {
  if (messaging.peerSocket.readyState === messaging.peerSocket.OPEN) {
    messaging.peerSocket.send(currentRun);
  }
}

function handleMessage(data) {
  if (data && data.command === "start") {
    recordRun();
  }
}

messaging.peerSocket.onmessage = (evt) => {
  handleMessage(evt.data);
};

startButton.style.display = "none";
stopButton.style.display = "none";
