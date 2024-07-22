![Header](./header.png)
### Overview
This application is designed to interact with a Fitbit device, collecting sensor readings and displaying them graphically on a mobile device. The mobile application is developed using Flutter and Dart, while the Fitbit interactions and WebSocket communication are handled using JavaScript. Collected data is stored in a Firestore Database, as well as user authentication is managed through Firebase Authentication.
### Features
- Real-time Sensor Data: Collect sensor readings from the Fitbit device and display them in real-time.
- Graphical Display: Visualize the collected data using interactive graphs.
- WebSocket Communication: Use WebSockets to transmit data from the Fitbit device to the mobile application.
- Data Storage: Store collected data in a Firebase database for later retrieval and analysis.
- User Authentication: Authenticate users via Google sign-in or email and password.

### Technologies Used
- Flutter and Dart: For developing the mobile application.
- JavaScript: For interfacing with the Fitbit device and managing WebSocket communication.
- Firebase: For data storage and user authentication.

### Installation and Setup
##### Prerequisites
- Flutter SDK (3.22.2)
- Dart SDK (3.4.3)
- Node.js (22.2.0)
- NPM (10.8.1) -> for JavaScript dependencies

You will need to know your machine’s IP address and modify the following files with your IP address to set up the application with the WebSocket.

##### To know your IP address:
- On Windows:
Press Win + R to open the Run dialog box.
Type “cmd” and press Enter to open Command Prompt.
Type ipconfig and press Enter.
Look for "IPv4 Address". This is your local IP address.
- On macOS:
Press command + space to open the spotlight search and type terminal, press return.
Type “ifconfig | grep inet” and press return.
Look for the IP address associated with en0 (usually Wi-Fi) or en1 (Ethernet).
- On Linux:
Open a Terminal.
Type ip addr show and press Enter.
Look for the IP address associated with your network adapter (e.g., eth0 or wlan0).

After getting the IP address modify these files with your IP address:
wearableGestureRecognitSystemion\fitbitApp\wearable-gesture-recognition-system\companion\index.js -> line 4
wearableGestureRecognitSystemion\mobileApp\gesture_detection\lib\activity pages\arm mobility test.dart -> line 39 
wearableGestureRecognitSystemion\mobileApp\gesture_detection\lib\activity pages\arm rotation test.dart -> line 39
wearableGestureRecognitSystemion\mobileApp\gesture_detection\lib\activity pages\balance stability test.dart -> line 38

##### Start WebSocket Server:
Navigate to the server directory:
```
cd <project directory> 
```
Start the server on local machine:
```
node server.js
```
##### Deploy Fitbit application:
Follow the [Fitbit SDK instructions](https://dev.fitbit.com/getting-started/) to deploy the JavaScript code to the Fitbit device.

##### Mobile Application Setup:
Clone the Repository:
```
git clone https://github.com/FIU-MOSAIC/wearableGestureRecognitionSystem.git
```
Navigate to the Project Directory:
```
cd <project directory> 
```
Install Dependencies:
```
flutter pub get
```
Run the Application:
```
flutter run
```
### Usage
Launch the Mobile Application:
Open the application on your mobile device.

Authenticate:
Sign in using Google or your email and password.

Connect the Fitbit:
Ensure your Fitbit device is connected and transmitting data via WebSocket.

Select the exercise:
Tap the activity you want to perform, see the instructions and press the start button.

View Data:
Real-time sensor data will be displayed graphically on the mobile application.

Data Storage:
Collected data is automatically stored in the Firebase database for future reference.

### License
This project is licensed under the [MIT License](https://opensource.org/license/mit)

### Acknowledgements
[Fitbit SDK Documentation](https://dev.fitbit.com/build/guides/)
[Flutter Documentation](https://docs.flutter.dev/get-started/install)
[Firebase Documentation](https://firebase.google.com/docs)
