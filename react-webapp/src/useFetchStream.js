import { useState, useEffect } from "react";
import { database, ref, onValue } from "./FirebaseSettings";
const useFetchStream = (sessionid) => {
  const [data, setData] = useState(null);
  const [isPending, setIsPending] = useState(true);
  const [error, setError] = useState(null);
  

  // if (sessionid !== null) {
  //   console.log("session id is not null");
  // } else {
  //   console.log("session id is not passed");
  // }

  useEffect(() => {
    // const abortCont = new AbortController();
    var dataRef;
    if (sessionid !== null) {
       dataRef = ref(database, "users/" + sessionid);
    } else {
      dataRef = ref(database, "users");
    } // Change to your data path}
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
