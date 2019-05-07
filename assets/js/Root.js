import React, { Component } from "react";
import DashboardContainer from "./containers/dashboard/DashboardContainer"
import gql from "graphql-tag";
import {Query} from "react-apollo";

const REPOSITORIES = gql`
{
  viewer{
      following(first: 20) {
      totalCount
        edges {
          node {
            url
            name
            isHireable
            
            repositories(first: 2, orderBy:{field: UPDATED_AT, direction: DESC}){
              edges {
                node {
                  name
                  updatedAt
                  url
                }
              }
            }
            
            starredRepositories(first: 2, orderBy:{field:STARRED_AT, direction: DESC}) {
              edges {
                starredAt
                node {
                  name
                  url
                }
              }
            }
            
            
            watching(first: 2, orderBy:{field:UPDATED_AT, direction: DESC}) {
              edges {
                node {
                  name
                  url
                }
              }
            }
          }
          cursor
        }
        pageInfo {
          hasNextPage
        }
    }
  }
}
`; 

export default class Root extends Component {
  render() {
    var id = "venomnert";
    return (
      <div className="form-container">
        <Query query={REPOSITORIES}>
          {({loading, error, data}) => {
            console.log("loading", loading)
            console.log("error", error)
            console.log("data", data)
            if(loading) return(<span>Loading...</span>);
            if(error) return(<span>Error</span>);
            return(<div class="github-data">{data.viewer.following.totalCount}</div>)
          }}
        </Query>
        <h2>Welcome</h2>
        <DashboardContainer />
      </div>
    )        
  }
}