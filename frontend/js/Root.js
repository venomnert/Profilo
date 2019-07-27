import React, { Component } from "react";
import DashboardContainer from "./containers/dashboard/DashboardContainer"
import SocialLinkList from '../components/SocialLinkList';
import gql from "graphql-tag";
import {Query} from "react-apollo";
import {ApolloProvider} from 'react-apollo';
import social_link_client from "../components/social_link_client";

const GET_GITHUB_SOCIAL_LINKS = gql `
query SocialLinks {
    socialLinks{
      name
      id
    }
  }
`;

export default class Root extends Component {
  render() {
    var id = "venomnert";
    return (
      <div className="form-container">
        <h2>Welcome</h2>
        {/* <DashboardContainer /> */}
        <ApolloProvider client={social_link_client}>
          <Query query={GET_GITHUB_SOCIAL_LINKS}>
              {({ data, loading, error}) => {
                  if(loading || data.socialLinks.length <= 0) return <p>Fetching social link data</p>;
                  if(error) return <p>error</p>;
                  return <SocialLinkList socialLinks={data.socialLinks}/>
              }}
          </Query>
        </ApolloProvider>, 
      </div>
    )        
  }
}