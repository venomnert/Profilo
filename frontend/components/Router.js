import React from "react";
import { BrowserRouter, Route, Switch } from "react-router-dom";
import Root from "./Root"
import Menu from "./Menu/Menu"

//Components
import Icons from "./Catalog/Icons"
import ProfileEditRoot from "./Profile/ProfileEditRoot"
import ListProfiles from "./Profile/ListProfiles"

const Router = (props) => {
    return(
      <BrowserRouter>
        <div id="app">
          <div id="content">
            <Switch>
              {/* Composition */}
              <Route path="/all-components" exact render={() => <Root data={props.data} />} />
              <Route path="/v1/app" exact render={() => <Root data={props.data} />} />
              <Route path="/v1/app/menu" exact render={() => <Menu data={props.data} />} />
              <Route path="/v1/app/menu/setting" component={Root} />  
              {/* Components */}
              <Route path="/v1/app/components/icons" component={Icons} />
              <Route path="/v1/app/components/profile-edit" exact render={() => <ProfileEditRoot data={props.data} />} />                     
              <Route path="/v1/app/components/list-profiles" exact render={() => <ListProfiles data={props.data} />} />                     
            </Switch>
          </div>
        </div>
      </BrowserRouter>
    )
};
  
  export default Router;

  // Import Router.js into App.js
  // Route all components through this