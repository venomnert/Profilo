
import Router from '../components/Router';
import * as React from 'react'
import * as ReactDOM from 'react-dom'
import {ApolloProvider} from 'react-apollo';
import gql from "graphql-tag";
import {Query} from "react-apollo";

import '../css/app.scss'
import 'phoenix_html'

import Root from './Root'
import RootUI from './RootUI'

import {$,jQuery} from 'jquery';
// export for others scripts to use
window.$ = $;
window.jQuery = jQuery;

import 'bootstrap';

import client from "../components/client";


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
  }
`;

if (document.getElementById('react-app')){
  ReactDOM.render(
      <ApolloProvider client={client}>
          <Query query={GET_STATE}>
                {({ data, loading, error}) => {
                    if(loading) return <p>Fetching data</p>;
                    if(error) return <p>error</p>;
                    return <Router data={data}/>
                }}
            </Query>
      </ApolloProvider>, 
  document.getElementById('react-app'))
} else {

  ReactDOM.render(<RootUI/>, document.getElementById('react-app-uikit'))

}



