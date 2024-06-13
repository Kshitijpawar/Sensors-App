import "./App.css";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import Navbar from "./Navbar";
import Home from "./Home";
import SingleStreamPage from "./SingleStreamPage";


function App() {
  return (
    <Router>
      <div className="App">
        <Navbar></Navbar>
        <div className="content">
          <Switch>
            <Route exact path="/">
              <Home></Home>
            </Route>
            <Route path= "/:streamid"><SingleStreamPage/></Route>
          </Switch>
        </div>
      </div>
    </Router>
  );
}

export default App;
