import { peerSocket } from "messaging";
import { Buffer } from "buffer";

// create a new websocket connection
const websocket = new WebSocket("ws://192.168.0.47:8080");

// event listener for websocket connection open
websocket.onopen = () => {
    console.log("websocket connection opened");
};

// event listener for websocket error
websocket.onerror = (error) => {
    console.error("websocket error:", error);
};

// event listener for messages from fitbit app
peerSocket.onmessage = (evt) => {
    const decodedData = Buffer.from(evt.data).toString();
    console.log("received data from fitbit app:", decodedData);
    if (websocket.readyState === WebSocket.OPEN) {
        websocket.send(decodedData);
        console.log("sent data to websocket server:", decodedData);
    } else {
        console.error("websocket is not open");
    }
};

// event listener for messages from websocket server
websocket.onmessage = (evt) => {
    console.log("received data from server:", evt.data);
};

// event listener for websocket connection close
websocket.onclose = () => {
    console.log("websocket connection closed");
};
