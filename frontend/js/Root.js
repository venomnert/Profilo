import React, { Component } from "react";
import DashboardContainer from "./containers/dashboard/DashboardContainer"

export default class Root extends Component {
  render() {
    var id = "venomnert";
    return (
      <div className="form-container">
        <h2>Welcome</h2>
        <DashboardContainer />
      </div>
    )        
  }
}