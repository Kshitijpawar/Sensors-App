import { useEffect, useState } from "react";
import { Line } from "react-chartjs-2";
import "chart.js/auto";
import { database, ref, onValue } from "./FirebaseSettings";

// // Import the functions you need from the SDKs you need
// import { initializeApp } from "firebase/app";
// import { getAnalytics } from "firebase/analytics";
// // import { getDatabase } from "firebase/database";
// import { getDatabase, ref, child, get } from "firebase/database";

// // Initialize Firebase
// const app = initializeApp(firebaseConfig);
// const analytics = getAnalytics(app);
// const db = ref(getDatabase(app));
// get(child(db, `users/`)).then((snapshot) => {
//     if (snapshot.exists()) {
//       console.log(snapshot.val());
//     } else {
//       console.log("No data available");
//     }
//   }).catch((error) => {
//     console.error(error);
//   });
// async function getUsers(db) {
//     const usersCol = collection(db, '/users');
//     const userSnapshot = await getDocs(usersCol);
//     console.log(userSnapshot);
//     // const cityList = citySnapshot.docs.map(doc => doc.data());
//     // return cityList;
//   }
//   getUsers(db);

const getRandomValue = () => Math.floor(Math.random() * 100);

const RandomValueComponent = () => {
  const [randomObject, setRandomObject] = useState([
    { value: getRandomValue() },
  ]);

  // useEffect(() => {
  //   const intervalId = setInterval(() => {
  //     //   setRandomObject({ value: getRandomValue() });
  //     setRandomObject((prevValues) => {
  //       const newValues = [...prevValues, { value: getRandomValue() }];
  //       if (newValues.length > 200) {
  //         newValues.shift();
  //       }
  //       return newValues;
  //     });
  //   }, 50); // Update every second

  //   return () => clearInterval(intervalId); // Cleanup interval on component unmount
  // }, []);

  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [accData, setAccData] = useState(null);
  useEffect(() => {
    const dataRef = ref(database, "users"); // Change to your data path

    const unsubscribe = onValue(
      dataRef,
      (snapshot) => {
        setData(snapshot.val());
        // console.log(data);
        if (snapshot.val() !== null) {
         setAccData( (prevValues) =>  { const newValues = Object.values(snapshot.val().newrecording.accelerometer).map(
          (entry) => entry.data.x
        );  return newValues.slice(-50); });
          console.log(accData);
        }

        setLoading(false);
      },
      (error) => {
        setError(error);
        setLoading(false);
      }
    );
    // console.log(typeof data);
    // Cleanup subscription on unmount
    return () => unsubscribe();
  }, []); // Empty dependencies array ensures this runs once after initial render
  if (loading) {
    return <p>Loading...</p>;
  }

  if (error) {
    return <p>Error: {error.message}</p>;
  }

  return (
    <div>
      <h1>Random Values:</h1>
      {/* <ul>
            {randomObject.map((item, index) => (
            <li key={index}>{item.value}</li>
            ))}
        </ul> */}
      <Line
        datasetIdKey="id"
        data={{
          labels: accData.map((item, index) => index),
          datasets: [
            {
              id: 1,
              label: "test_label 1 ",
              //   data: [5, 6, 7],
              data: accData,
            },
            // {
            //   id: 2,
            //   label: "test_label 2",
            //   data: [3, 2, 1],
            // },
          ],
        }}
      />
      {/* {console.log(Object.values(data.newrecording.accelerometer).map((entry) => entry.data.x))} */}
      {/* <pre>{JSON.stringify(data, null, 2)}</pre> */}
      {/* <pre>{JSON.stringify(accData, null, 2)}</pre> */}
      <pre>{JSON.stringify(accData, null, 2)}</pre>
    </div>
  );
};

export default RandomValueComponent;
