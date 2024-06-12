# Project Title: Sensor Data Visualization and Streaming
## Website hosted on Firebase
https://sensorappdb.web.app/
## Motivation
A data collection application which can be used to record sensors onboard smartphones for smart visualization and detection of anomalies or events
## Overview

This project comprises two applications:

1. **Flutter Mobile App**: A mobile application built using Flutter to monitor and record sensor data (accelerometer and gyroscope) and stream it to Firebase Realtime Database.
2. **React JS Web App**: A web application built using React JS to view and chart the recorded sensor data from Firebase Realtime Database.

## Flutter Mobile App

### Features

- **Sensor Data Visualization**:

  - One screen displays the accelerometer and gyroscope data.
  - Data is charted using a custom painter class for dynamic visualization.
    <!-- ![Mobile App Sensor Data Visualization](git_images\Screenshot_20240509-132226.png) -->
    <p align= "left">
      <img src="git_images\Screenshot_20240611-215230.png" alt="Custom Painter class for viz." width="300">
    </p>

- **Data Recording and Streaming**:
  - Records sensor values (accelerometer and gyroscope).
  - Streams the recorded data to Firebase Realtime Database in real-time.
  <p align="left">
    <img src="git_images\Screenshot_20240611-215248.png" alt="Dialog box for streaming" width="300">
    <img src="git_images\Screenshot_20240611-215254.png" alt="Statusfor streaming" width="300">
  </p>

### Images

### Installation and Setup

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/Kshitijpawar/Sensors-App.git
   cd Sensors-App/flutter-sensors-app
   ```

2. **Install Dependencies**:

   ```bash
   flutter pub get
   ```

3. **Run the App**:
   ```bash
   flutter run
   ```

### Configuration

- Ensure you have the correct Firebase configuration in `lib/firebase_options.dart`. You can create one on Firebase console for free.
- Update your `pubspec.yaml` file with necessary dependencies.

## React JS Web App

### Features

- **Data Visualization**:
  - Reads accelerometer and gyroscope data from Firebase Realtime Database.
  - Uses Chart.js to visualize the recorded sensor data in real-time.
  <p align="center">
    <img src="git_images\Screenshot 2024-06-11 220038.png" alt="React webapp homepage" width="900">
    <img src="git_images\Screenshot 2024-06-11 220005.png" alt="Charts page" width="900">
  </p>

### Installation and Setup

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/Kshitijpawar/Sensors-App.git
   cd Sensors-App/react-webapp
   ```

2. **Install Dependencies**:

   ```bash
   npm install
   ```

3. **Run the App**:
   ```bash
   npm start
   ```

### Configuration

- Ensure you have the correct Firebase configuration in `src/FirebaseSettings.js`.

## Future To-Dos

1. **Enhance Mobile App**:

   - Add more sensors and data visualization screens.
   - Implement offline data storage and sync when the network is available.

2. **Improve Web App**:

   - Add user authentication for secure data access.
   - Implement data export functionality (CSV, Excel).
   - Enhance data visualization with more chart options and customization.

3. **General Improvements**:
   - Optimize data streaming and database interactions.
   - Improve the user interface and user experience across both apps.
   - Conduct extensive testing and bug fixing.

## Contributing

Contributions are welcome! Please fork this repository and submit pull requests.

## License

<!-- This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details. -->
See the [LICENSE](LICENSE) file for details.

## Contact

For any queries or suggestions, please contact [kshitijvijay271199@gmail.com](mailto:your-email@example.com).
