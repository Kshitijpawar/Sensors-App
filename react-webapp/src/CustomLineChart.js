import { useState } from "react";
import { Line } from "react-chartjs-2";
import "chart.js/auto";

const CustomLineChart = (streamData) => {
  //   const [accData, setAccData] = useState(null);
  const [accStateData, setAccStateData] = useState(null);
  const [gyroStateData, setGyroStateData] = useState(null);
  var accData, accXData, accYData, accZData;
  var gyroData, gyroXData, gyroYData, gyroZData;
  var timestampData;
  // console.log(streamData.streamData);
  // console.log(streamData.streamData.hasOwnProperty("gyroscope"));
  // accelerometer variables
  try {
    accData = streamData.streamData["accelerometer"];
    accXData = Object.values(accData).map((idx) => idx.data.x);
    accYData = Object.values(accData).map((idx) => idx.data.y);
    accZData = Object.values(accData).map((idx) => idx.data.z);
  } catch {}

  // gyro variables
  try {
    // setGyroStateData(streamData.streamData["gyroscope"]);
    gyroData = streamData.streamData["gyroscope"];
    gyroXData = Object.values(gyroData).map((idx) => idx.data.x);
    gyroYData = Object.values(gyroData).map((idx) => idx.data.y);
    gyroZData = Object.values(gyroData).map((idx) => idx.data.z);
  } catch {}

  // const gyroXData = Object.values(gyroData).map((idx) => idx.data.x);
  // const gyroYData = Object.values(gyroData).map((idx) => idx.data.y);
  // const gyroZData = Object.values(gyroData).map((idx) => idx.data.z);
  if (accData !== undefined) {
    timestampData = Object.values(accData).map((idx) => idx.data.timestamp);
  } else {
    // console.log(gyroData);
    timestampData = Object.values(gyroData).map(
      (idx) => idx.data.timestamp
    );
  }
// console.log(timestampData);
  return (
    <div>
      {/* {console.log(streamData.streamData)} */}
      {accData !== undefined ? (
        <>
          <h2>Accelerometer Chart of last 50 data points</h2>
          {/* <pre>
        {accData &&
          JSON.stringify(
            Object.values(accData).map((idx) => idx.data.x),
            null,
            2
          )}
      </pre> */}
          <Line
            datasetIdKey="id"
            data={{
              labels: timestampData.slice(-50),
              datasets: [
                {
                  id: 1,
                  label: "accX ",
                  data: accXData.slice(-50),
                },
                {
                  id: 2,
                  label: "accY ",
                  data: accYData.slice(-50),
                },
                {
                  id: 3,
                  label: "accZ ",
                  data: accZData.slice(-50),
                },
              ],
            }}
          />
          <h2>Historic Acc Data</h2>
          <Line
            datasetIdKey="id"
            data={{
              labels: timestampData,
              datasets: [
                {
                  id: 1,
                  label: "accX ",
                  data: accXData,
                },
                {
                  id: 2,
                  label: "accY ",
                  data: accYData,
                },
                {
                  id: 3,
                  label: "accZ ",
                  data: accZData,
                },
              ],
            }}
          />
        </>
      ) : (
        <p> Accelerometer Data not present in database</p>
      )}
      {gyroData !== undefined ? (
        <>
          <h2>Gyroscope Chart of last 50 data points</h2>
          <Line
            datasetIdKey="id"
            data={{
              labels: timestampData.slice(-50),
              datasets: [
                {
                  id: 1,
                  label: "gyroX ",
                  data: gyroXData.slice(-50),
                },
                {
                  id: 2,
                  label: "gyroY ",
                  data: gyroYData.slice(-50),
                },
                {
                  id: 3,
                  label: "gyroZ ",
                  data: gyroZData.slice(-50),
                },
              ],
            }}
          />
          <h2>Historic Gyro Data</h2>
          <Line
            datasetIdKey="id"
            data={{
              labels: timestampData,
              datasets: [
                {
                  id: 1,
                  label: "gyroX ",
                  data: gyroXData,
                },
                {
                  id: 2,
                  label: "gyroY ",
                  data: gyroYData,
                },
                {
                  id: 3,
                  label: "accZ ",
                  data: gyroZData,
                },
              ],
            }}
          />
        </>
      ) : (
        <p> Gyroscope Data not present in database</p>
      )}

      {/*  */}
    </div>
  );
};

export default CustomLineChart;
