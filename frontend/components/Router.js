import React from "react";
import { BrowserRouter, Route, Switch } from "react-router-dom";
import Root from "./Root";
import Menu from "./Menu";
import ManageProfiles from "./ManageProfiles";
import Profiles from "./Profiles";

//Components
import Icons from "./Catalog/Icons"
import ProfileEditRoot from "./Profile/ProfileEditRoot"
import ListProfiles from "./Profile/ListProfiles"
import NotFound from "./NotFound"

const Router = (props) => {

    return(
      <BrowserRouter basename="/v1/app">
        <div id="app">
          <div id="content">
            <Switch>
              {/* Paths */}
              <Route path="/" exact render={() => <Root data={props} />} /> 
              <Route path="/menu" exact render={() => <Menu data={props} />}/>
              <Route path="/menu/profiles" exact render={() => <Profiles data={props} />} />
              <Route path="/menu/profiles/manage" exact render={() => <ManageProfiles data={props} />} />
              <Route path="/menu/settings" exact render={() => <Menu data={props} />} />
              <Route component={NotFound} />
              
              {/* Composition */}
              <Route path="/all-components" exact render={() => <Root data={props} />} />
              <Route path="/menu" exact render={() => <Menu data={props} />} />
              <Route path="/menu/setting" component={Root} />  
              
              {/* Components */}
              <Route path="/components/icons" component={Icons} />
              <Route path="/components/profile-edit" exact render={() => <ProfileEditRoot data={props} />} />                     
              <Route path="/components/list-profiles" exact render={() => <ListProfiles data={props} />} />                     
            </Switch>
          </div>
        </div>
      </BrowserRouter>
    )
};
  
  export default Router;

  // Import Router.js into App.js
  // Route all components through this