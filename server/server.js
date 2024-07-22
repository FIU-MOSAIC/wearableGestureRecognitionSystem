const WebSocket = require('ws');
const express = require('express');
const bodyParser = require('body-parser');

const app = express();
const wsPort = 8080; // websocket server port

// set up websocket server
const wss = new WebSocket.Server({ port: wsPort });

wss.on('connection', (ws) => {
    console.log('client connected');

    ws.on('message', (message) => {
        const data = JSON.parse(message.toString());
        console.log('received data:', data);
        
        // broadcast data to all connected clients
        wss.clients.forEach(client => {
            if (client.readyState === WebSocket.OPEN) {
                client.send(JSON.stringify(data));
            }
        });
    });

    ws.on('close', () => {
        console.log('client disconnected');
    });

    ws.on('error', (error) => {
        console.error('websocket error:', error);
    });
});

console.log(`websocket server is running on ws://localhost:${wsPort}`);
