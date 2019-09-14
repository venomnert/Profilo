import * as React from 'react'
import * as ReactDOM from 'react-dom'
import Router from './Router';
import {ApolloProvider, withApollo} from 'react-apollo';
import {ApolloProvider as ApolloHooksProvider} from '@apollo/react-hooks';
import {Query} from "react-apollo";
import gql from "graphql-tag";
import 'bootstrap';

import '../css/app.scss'
import 'phoenix_html'

import Root from './Root'
// import RootUI from '../js/RootUI'

import {$,jQuery} from 'jquery';
// export for others scripts to use
window.$ = $;
window.jQuery = jQuery;


import client from "./client";


const GET_STATE = gql `
  query GetState {
    socialLinks{
      name
      id
    }
    followings {
      name
      screenName
      id
      profileId
      socialLinkId
      avatarUrl
    }
    profiles{
      name
      id
      avatarUrl
    }
    feedNodes(profileId: 1){
        description
        id
        socialLinkId
        profileId
    }
  }
`;

const RouterWithApollo = withApollo(Router);

if (document.getElementById('react-app')){
  ReactDOM.render(
      <ApolloProvider client={client}>
        <ApolloHooksProvider client={client}>
          <Query query={GET_STATE}>
                {({ data, loading, error}) => {
                    if(loading) return <p>Fetching data</p>;
                    if(error) return <p>error</p>;
                    return <RouterWithApollo data={data}/>
                }}
            </Query>
          </ApolloHooksProvider>
      </ApolloProvider>, 
  document.getElementById('react-app'))
} 
else {
  // ReactDOM.render(<RootUI/>, document.getElementById('react-app-uikit'))
}



