import * as document from "document";
import { Accelerometer } from "accelerometer";
import { display } from "display";

const elem = document.getElementById("myElem");
elem.text = `x: y: z:`;

if(Accelerometer){
    console.log("this device has an accelerometer");
    const acc = new Accelerometer({ frequency: 1 });

    acc.addEventListener("reading", () => {
        console.log(
            `ts: ${acc.timestamp}, \
            x: ${acc.x}, \
            y: ${acc.y}, \
            z: ${acc.z}`
        );
    });

    display.addEventListener("change", () => {
        if(display.on){
            acc.start();
        } else {
            acc.stop();
        }
    });

    acc.start();
} else {
    console.log("this device does not have an accelerometer");
}