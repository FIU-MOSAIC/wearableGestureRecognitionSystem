const WebSocket = require('ws');
const express = require('express');
const bodyParser = require('body-parser');

const app = express();
const wsPort = 8080; // WebSocket server port

// Set up WebSocket server
const wss = new WebSocket.Server({ port: wsPort });

wss.on('connection', (ws) => {
    console.log('Client connected');

    ws.on('message', (message) => {
        const data = JSON.parse(message.toString());
        console.log('Received data:', data);
        
        // Broadcast data to all connected clients
        wss.clients.forEach(client => {
            if (client.readyState === WebSocket.OPEN) {
                client.send(JSON.stringify(data));
            }
        });
    });

    ws.on('close', () => {
        console.log('Client disconnected');
    });

    ws.on('error', (error) => {
        console.error('WebSocket error:', error);
    });
});

console.log(`WebSocket server is running on ws://localhost:${wsPort}`);
