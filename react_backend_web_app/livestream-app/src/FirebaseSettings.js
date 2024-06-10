// firebase.js
import { initializeApp } from "firebase/app";
import { getDatabase, ref, onValue } from "firebase/database";

// Your web app's Firebase configuration
const firebaseConfig = {
    apiKey: "AIzaSyB_Wj2j0oEChEN9CnKX6Pi47MQWhleIpCs",
    authDomain: "flutter-prep-bda5b.firebaseapp.com",
    databaseURL: "https://flutter-prep-bda5b-default-rtdb.firebaseio.com",
    projectId: "flutter-prep-bda5b",
    storageBucket: "flutter-prep-bda5b.appspot.com",
    messagingSenderId: "917185126462",
    appId: "1:917185126462:web:3a1fac91a412f96007f16f",
    measurementId: "G-G2X0P7Q0QE"
  };

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const database = getDatabase(app);

export { database, ref, onValue };
