import '../css/app.scss'

import 'phoenix_html'

import * as React from 'react'
import * as ReactDOM from 'react-dom'
import Root from './Root'
import RootUI from './RootUI'

import {$,jQuery} from 'jquery';
// export for others scripts to use
window.$ = $;
window.jQuery = jQuery;

import 'bootstrap';

import ApolloClient from "apollo-boost";
import {ApolloProvider} from 'react-apollo';

async function get_token() {
    const response = await fetch('/api/auth/github') ;
    const json = await response.json();
    return json;
}
get_token().then((data) => {
    // console.log("github auth", data);
    const api_client = new ApolloClient({
        uri: "https://api.github.com/graphql",
        request: async operation => {
            operation.setContext({
                headers: {
                //    authorization: `token 850ea2229e4bbbb7997ddd12c9f318103d28a173`
                   authorization: `token ${data.access_token}`
                }
            });
        }
    })
    
    ReactDOM.render(
    <ApolloProvider client={api_client}>
        <Root />
    </ApolloProvider>, 
    document.getElementById('react-app'))
});

ReactDOM.render(<RootUI />, document.getElementById('react-app-uikit'))
