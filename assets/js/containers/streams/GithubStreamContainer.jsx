import React, { Component } from "react";
import gql from "graphql-tag";
import {Query} from "react-apollo";

import GithubStream from "./GithubStream";

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

class GithubStreamContainer extends Component {
    constructor(props) {
        super(props);

        this.state = {
            user: {}
        }

    }
    render() {
        return (
            <div>
                <Query query={REPOSITORIES}>
                    {({loading, error, data}) => {
                        console.log("loading", loading)
                        console.log("error", error)
                        console.log("data", data)
                        if(loading) return(<span>Loading...</span>);
                        if(error) return(<span>Error</span>);
                        return(
                          <div class="github-data">
                            <GithubStream data={data.viewer}/>
                          </div>
                        )
                    }}
                </Query>
            </div>
        );
    }
}

export default GithubStreamContainer;
