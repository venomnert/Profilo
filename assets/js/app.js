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

const api_client = new ApolloClient({
    uri: "https://api.github.com/graphql",
    request: async operation => {
        operation.setContext({
            headers: {
                // authorization: `token ${process.env.REACT_APP_GITHUB_TOKEN}`
                authorization: `token 142993ee80d11d6bec8b4089d8cc3b1b28cc0df0`
            }
        });
    }
})

ReactDOM.render(
<ApolloProvider client={api_client}>
    <Root />
</ApolloProvider>, 
document.getElementById('react-app'))