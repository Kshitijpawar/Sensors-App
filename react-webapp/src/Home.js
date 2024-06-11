// import RandomValueComponent from "./RandomValueComponent";
import StreamSession from "./StreamSession";

const Home = () => {
//   const [chartData, setChartData] = useState({
//     labels: Data.map((data) => data.year),
//     datasets: [
//       {
//         label: "Users Gained ",
//         data: Data.map((data) => data.userGain),
//         backgroundColor: [
//           "rgba(75,192,192,1)",
//           "#ecf0f1",
//           "#50AF95",
//           "#f3ba2f",
//           "#2a71d0",
//         ],
//         borderColor: "black",
//         borderWidth: 2,
//       },
//     ],
//   });
  return (
    <div className="home">
      <h2>Homepage</h2>
      {/* <PieChart chartData={chartData}></PieChart> */}
      {/* <Line
        datasetIdKey="id"
        data={{
          labels: ["Jun", "Jul", "Aug"],
          datasets: [
            {
              id: 1,
              label: "test_label 1 ",
            //   data: [5, 6, 7],
                data: GetData.map((data) => data.val),
        },
            // {
            //   id: 2,
            //   label: "test_label 2",
            //   data: [3, 2, 1],
            // },
          ],
        }}
      /> */}

      {/* <RandomValueComponent></RandomValueComponent> */}
      <StreamSession />
    </div>
  );
};

export default Home;
