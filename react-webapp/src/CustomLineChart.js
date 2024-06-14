import { useState } from "react";
import { Line } from "react-chartjs-2";
import "chart.js/auto";
import CustomMap from "./CustomMap";

const CustomLineChart = (streamData) => {
  var accData, accXData, accYData, accZData;
  var gyroData, gyroXData, gyroYData, gyroZData;
  var timestampData;
  var locationData, latVal, longVal;
  var coordinatesData = [];
  const coordinates = [
    [51.505, -0.09],
    [51.51, -0.1],
    [51.51, -0.12],
  ];
  // accelerometer variables
  try {
    accData = streamData.streamData["accelerometer"];
    accXData = Object.values(accData).map((idx) => idx.data.x);
    accYData = Object.values(accData).map((idx) => idx.data.y);
    accZData = Object.values(accData).map((idx) => idx.data.z);
  } catch {}

  // gyro variables
  try {
    gyroData = streamData.streamData["gyroscope"];
    gyroXData = Object.values(gyroData).map((idx) => idx.data.x);
    gyroYData = Object.values(gyroData).map((idx) => idx.data.y);
    gyroZData = Object.values(gyroData).map((idx) => idx.data.z);
  } catch {}

    try{
      locationData = streamData.streamData["location"];
      
      latVal = Object.values(locationData).map((idx) => idx.data.latitude);
      longVal = Object.values(locationData).map((idx) => idx.data.longitude);
       coordinatesData = latVal.map((lat, index) => [lat, longVal[index]]);

      console.log(coordinatesData);
    }catch{}

  if (accData !== undefined) {
    timestampData = Object.values(accData).map((idx) => idx.data.timestamp);
  } else {
    // console.log(gyroData);
    timestampData = Object.values(gyroData).map((idx) => idx.data.timestamp);
  }
  // console.log(timestampData);
  return (
    <>
      <div className="custom-line-chart">
        {accData !== undefined ? (
          <>
            <h2>Accelerometer Chart of last 50 data points</h2>
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
      </div>
      <>
        {/* <CustomMap coordinates= {coordinates} /> */}
        <CustomMap coordinates= {coordinatesData} />
      </>
    </>
  );
};

export default CustomLineChart;
