import React, { Component } from "react";
import Profiles from "./ui_elements/profiles";

export default class Root extends Component {
  render() {
    return (
      <div className="form-container">
        <h2>Profiles</h2>
        <Profiles />
      </div>
    )        
  }
}