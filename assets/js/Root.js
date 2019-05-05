import React, { Component } from "react";
import DashboardContainer from "./containers/dashboard/DashboardContainer"
import gql from "graphql-tag";
import {Query} from "react-apollo";

const REPOSITORIES = gql`
{
  viewer { 
    login
  }
}
`; 

export default class Root extends Component {
  render() {
    return (
      <div className="form-container">
        <Query query={REPOSITORIES}>
          {({loading, error, data}) => {
            console.log("loading", loading)
            console.log("error", error)
            console.log("data", data)
            if(loading) return(<span>Loading...</span>);
            if(error) return(<span>Error</span>);
            return(<div class="github-data">{data.viewer.login}</div>)
          }}
        </Query>
        <h2>Welcome</h2>
        <DashboardContainer />
      </div>
    )        
  }
}