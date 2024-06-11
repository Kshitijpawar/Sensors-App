import { useState } from "react";
import { Line } from "react-chartjs-2";
import "chart.js/auto";

const CustomLineChart = (streamData) => {
  //   const [accData, setAccData] = useState(null);
  // if(streamData.accelerometer !== null)
  //   if (streamData !== null) {

  // accelerometer variables
  const accData = streamData.streamData["accelerometer"];
  const accXData = Object.values(accData).map((idx) => idx.data.x);
  const accYData = Object.values(accData).map((idx) => idx.data.y);
  const accZData = Object.values(accData).map((idx) => idx.data.z);

    // gyro variables
  const gyroData = streamData.streamData["gyroscope"];
  const gyroXData = Object.values(gyroData).map((idx) => idx.data.x);
  const gyroYData = Object.values(gyroData).map((idx) => idx.data.y);
  const gyroZData = Object.values(gyroData).map((idx) => idx.data.z);
  const timestampData = Object.values(accData).map((idx) => idx.data.timestamp);
//   console.log(timestampData);
//   console.log(accData);
  //  setAccData(streamData.streamData);
  //   }

  //   if (accData === null)
  // return (<div> Loading property</div>);
  //   const gyroData = streamData.gyroscope;
  //   console.log(accData);
  //   console.log(streamData.accelerometer);

  return (
    <div>
      <h2>Accelerometer Chart</h2>
      {/* <pre>
        {accData &&
          JSON.stringify(
            Object.values(accData).map((idx) => idx.data.x),
            null,
            2
          )}
      </pre> */}
      {/* <Line
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
      <h2>Gyroscope Chart</h2>
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
      /> */}
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
    </div>
  );
};

export default CustomLineChart;
