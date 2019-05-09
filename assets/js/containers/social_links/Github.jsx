import React, { Component } from "react";
import gql from "graphql-tag";
import {Query} from "react-apollo";

const REPOSITORIES = gql`
{
  viewer{
      name
  }
}
`; 

class Github extends Component {
    render() {
        return (
            <Query query={REPOSITORIES}>
                {({loading, error, data}) => {
                    if(error) {
                        return(
                            <li className="social-list__item">
                                <a href="/auth/github/new">Github needs to be setup</a>
                            </li>
                        );
                    }
                    return(
                        <li className="social-list__item">
                            Github is setup
                        </li>
                    )
                }}
            </Query>
        );
    }
}

export default Github;
