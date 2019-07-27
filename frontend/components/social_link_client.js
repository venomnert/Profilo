import { ApolloClient } from "apollo-client";
import { createHttpLink } from "apollo-link-http";
import { InMemoryCache } from "apollo-cache-inmemory";

const HTTP_ENDPOINT = "/graphql/v1";

const httpLink = createHttpLink({
    uri: HTTP_ENDPOINT
})

const client = new ApolloClient({
    link: httpLink,
    cache: new InMemoryCache()
})

export default client
