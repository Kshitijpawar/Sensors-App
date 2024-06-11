// import { ref } from "firebase/database";
import { useEffect, useState } from "react";
// import { database, ref, onValue } from "./FirebaseSettings";
import { Link } from "react-router-dom";
import useFetchStream from "./useFetchStream";

const StreamSession = () => {
  // const [streamSessions, setStreamSessions] = useState(null);
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
      {/* {console.log(dataTest)} */}
      {dataTest === null ? (
        <div>
          <p>No sessions present</p>
        </div>
      ) : (
        <div>
          <p>Click on any session below to view charts</p>
        </div>
      )}
      {dataTest &&
        Object.keys(dataTest).map((key) => (
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
