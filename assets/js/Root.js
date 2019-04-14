import React, { Component } from "react";
import UserRegisterationContainer from "./containers/forms/UserRegisterationContainer"
import UserLogin from "./containers/forms/UserLogin"
import UserLogout from "./containers/forms/UserLogout"

export default class Root extends Component {
  render() {
    return (
      <div className="form-container">
        <h2>Register for Profilo</h2>
        <UserRegisterationContainer />
        {/* <UserLogin /> */}
        {/* <UserLogout /> */}
      </div>
    )        
  }
}