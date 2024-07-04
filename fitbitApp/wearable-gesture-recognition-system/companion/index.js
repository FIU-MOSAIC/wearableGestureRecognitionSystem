import { peerSocket } from "messaging";
import { Buffer } from "buffer";

const websocket = new WebSocket("ws://192.168.0.13:8081");

websocket.onopen = () => {
    console.log("WebSocket connection opened");
};

websocket.onerror = (error) => {
    console.error("WebSocket error:", error);
};

peerSocket.onmessage = (evt) => {
    const decodedData = Buffer.from(evt.data).toString();
    console.log("Received data from Fitbit app:", decodedData);
    if (websocket.readyState === WebSocket.OPEN) {
        websocket.send(decodedData);
        console.log("Sent data to WebSocket server:", decodedData);
    } else {
        console.error("WebSocket is not open");
    }
};

websocket.onmessage = (evt) => {
    console.log("Received data from server:", evt.data);
};

websocket.onclose = () => {
    console.log("WebSocket connection closed");
};
