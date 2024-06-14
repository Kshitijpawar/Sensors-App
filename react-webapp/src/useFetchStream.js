import { useState, useEffect } from "react";
import { database, ref, onValue } from "./FirebaseSettings";
const useFetchStream = (sessionid) => {
  const [data, setData] = useState(null);
  const [isPending, setIsPending] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    var dataRef;
    if (sessionid !== null) {
      dataRef = ref(database, "users/" + sessionid);
    } else {
      dataRef = ref(database, "users");
    }
    const subscribeEvent = onValue(
      dataRef,
      (snapshot) => {
        setData(snapshot.val());
        setIsPending(false);
      },
      (error) => {
        setError(error);
        setIsPending(false);
      }
    );
    return () => subscribeEvent();
  }, [sessionid]);
  return { data, isPending, error };
};

export default useFetchStream;
