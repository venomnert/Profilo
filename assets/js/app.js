import '../css/app.scss'

import 'phoenix_html'

import * as React from 'react'
import * as ReactDOM from 'react-dom'
import Root from './Root'

import {$,jQuery} from 'jquery';
// export for others scripts to use
window.$ = $;
window.jQuery = jQuery;

import 'bootstrap';

import ApolloClient from "apollo-boost";
import {ApolloProvider} from 'react-apollo';

var token = null;
fetch('/api/github', {
    headers: { "Content-Type": "application/json; charset=utf-8" },
    method: 'GET'
  })        
  .then(res => res.json())
  .then((data) => {
    console.log("GITHUB FRONT VALUE", data);
  })

const api_client = new ApolloClient({
    uri: "https://api.github.com/graphql",
    request: async operation => {
        operation.setContext({
            headers: {
               authorization: `token 34d89621e103c910ec51468e3dece808e1820384`
            }
        });
    }
})

ReactDOM.render(
<ApolloProvider client={api_client}>
    <Root />
</ApolloProvider>, 
document.getElementById('react-app'))