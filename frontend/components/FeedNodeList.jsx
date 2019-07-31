import React from "react";
import FeedNode from "./FeedNode"
import gql from "graphql-tag";
import {Query} from "react-apollo";

const GET_PROFILE_FEEDNODES = gql `
query($id: Int){
    feedNodes(profileId: $id){
        description
        id
        socialLinkId
        profileId
    }
}
`;
const FeedNodeList = ({profile}) => {
    if (!profile) return <p>There are no profiles</p>;

    let query_variable = {id: parseInt(profile.id)}

    return (
        <Query query={GET_PROFILE_FEEDNODES}
               variables={query_variable}>
            {({ data, loading, error}) => {
                if(loading) return <p>Fetching data</p>;
                if(error) return <p>error</p>;
                return <FeedNode data={data}/>
            }}
        </Query>
    );
};

export default FeedNodeList 