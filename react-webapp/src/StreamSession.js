import { useState } from "react";
import { Link } from "react-router-dom";
import useFetchStream from "./useFetchStream";

const StreamSession = () => {
  const [error, setError] = useState(null);
  const { data: dataTest, isPending, error: errorTest } = useFetchStream(null);
  if (isPending) {
    return <p>Loading...</p>;
  }

  if (error) {
    return <p>Error: {error.message}</p>;
  }
  return (
    <div className="stream-sessions">
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
            <Link to={`/${key}`}>
              <h2>{key}</h2>
            </Link>
          </div>
        ))}
    </div>
  );
};

export default StreamSession;
