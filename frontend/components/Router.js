import React from "react";
import { BrowserRouter, Route, Switch } from "react-router-dom";
import Root from "../js/Root"
import Menu from "../components/Menu/Menu"

const Router = (props) => {
    console.log("RouterJS");
    console.log(props);
    return(
        <BrowserRouter>
        <div id="app">
          <div id="content">
            <Switch>
              <Route path="/app" exact render={() => <Root data={props.data} />} />
              <Route path="/app/menu" exact component={Menu} />
              <Route path="/app/menu/profiles" component={Root} />
              <Route path="/app/menu/setting" component={Root} />              
            </Switch>
          </div>
        </div>
      </BrowserRouter>
    )
};
  
  export default Router;

  // Import Router.js into App.js
  // Route all components through this