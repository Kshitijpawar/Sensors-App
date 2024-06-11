// import { ref } from "firebase/database";
import { useEffect, useState } from "react";
import { database, ref, onValue } from "./FirebaseSettings";
import { Link } from "react-router-dom";
import useFetchStream from "./useFetchStream";

const StreamSession = () => {
  const [streamSessions, setStreamSessions] = useState(null);
//   const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const { data: dataTest, isPending, error: errorTest } = useFetchStream(null);

// console.log(dataTest);
  if (isPending) {
    return <p>Loading...</p>;
  }

  if (error) {
    return <p>Error: {error.message}</p>;
  }
  return (
    <div className="stream-sessions">
      {/* <p>Hello World {if(dataTest === null) {return }}</p> */}
      {/* <p>{isPen}</p> */}
      {/* {dataTest || <p>bruh</p>} */}
      {dataTest && Object.keys(dataTest).map((key) => (
        <div className="stream-links" key={key}>
          {/* <a href={key}>
            {key}
          </a> */}
          <Link to={`/${key}`}>
            <h2>{key}</h2>
          </Link>
          {/* <br></br> */}
        </div>
      ))}
    </div>
  );
};

export default StreamSession;
