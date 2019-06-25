import React, { Component } from "react";
import Profiles from "./ui_elements/profiles";
import Social_Links from "./ui_elements/social_links";

export default class Root extends Component {
  render() {
    return (
      <div className="container">
        <div className="row">
          <h2>Profiles</h2>
          <Profiles />
        </div>
        
        <div className="row">
          <h2>Connect Social Links</h2>
          <Social_Links />
        </div>
      </div>
    )        
  }
}