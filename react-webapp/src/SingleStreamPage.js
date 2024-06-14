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
  return (
    <>
        {dataTest && <CustomLineChart streamData={dataTest} />}
    </>
  );
};

export default SingleStreamPage;
