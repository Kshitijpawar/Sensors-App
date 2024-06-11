import { useParams } from "react-router-dom";
import useFetchStream from "./useFetchStream";
import CustomLineChart from "./CustomLineChart";

const SingleStreamPage = () => {
  const { streamid } = useParams();
  const {
    data: dataTest,
    isPending,
    error: errorTest,
  } = useFetchStream(streamid);
//   console.log(dataTest);
  return (
    <div>
      {/* Hello World we're at {streamid} */}
      <div>
        {dataTest && <CustomLineChart streamData={dataTest} />}
      </div>
    </div>
  );
};

export default SingleStreamPage;
