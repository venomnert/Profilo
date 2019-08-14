import React from "react";
import { BrowserRouter, Route, Switch } from "react-router-dom";
import Root from "../js/Root"
import Menu from "../components/Menu/Menu"

const Router = (props) => {
    return(
        <BrowserRouter>
        <div id="app">
          <div id="content">
            <Switch>
              <Route path="/v1/app" exact render={() => <Root data={props.data} />} />
              <Route path="/v1/app/menu" exact render={() => <Menu data={props.data} />} />
              <Route path="/v1/app/menu/setting" component={Root} />              
            </Switch>
          </div>
        </div>
      </BrowserRouter>
    )
};
  
  export default Router;

  // Import Router.js into App.js
  // Route all components through this