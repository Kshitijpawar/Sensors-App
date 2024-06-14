import "./App.css";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import Navbar from "./Navbar";
import Home from "./Home";
import SingleStreamPage from "./SingleStreamPage";
import CustomMap from "./CustomMap";

function App() {
  return (
    <Router>
      <div className="App">
        <Navbar></Navbar>
        <div className="content-single-page">
          {/* <> */}
          <Switch>
            <Route exact path="/">
              <Home></Home>
            </Route>
            <Route path="/map">
              <CustomMap/>
            </Route>
            <Route path="/:streamid">
              <SingleStreamPage />
            </Route>
            
          </Switch>
        </div>
        {/* </> */}
      </div>
    </Router>
  );
}

export default App;
