const WebSocket = require('ws');
const express = require('express');
const bodyParser = require('body-parser');

const app = express();
const httpPort = 8083; // Changed from 8080 to 8083
const wsPort = 8081; // Keep the WebSocket server port as 8081 or change if needed

// Set up WebSocket server
const wss = new WebSocket.Server({ port: wsPort });

wss.on('connection', (ws) => {
    console.log('Client connected');

    ws.on('close', () => {
        console.log('Client disconnected');
    });

    ws.on('error', (error) => {
        console.log('WebSocket error:', error);
    });
});

console.log(`WebSocket server is running on ws://localhost:${wsPort}`);

// Set up HTTP server
app.use(bodyParser.json());

app.post('/data', (req, res) => {
    const data = req.body;
    console.log('Received data:', data);

    // Broadcast data to all WebSocket clients
    wss.clients.forEach(client => {
        if (client.readyState === WebSocket.OPEN) {
            client.send(JSON.stringify(data));
        }
    });

    res.status(200).send({ message: 'Data received successfully' });
});

app.listen(httpPort, () => {
    console.log(`HTTP server is running on http://localhost:${httpPort}`);
});
