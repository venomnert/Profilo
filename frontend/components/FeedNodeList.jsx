import React, { Component } from "react";
import gql from "graphql-tag";
import {Query} from "react-apollo";

import FeedNodeQuery from "./FeedNodeQuery"
import Profile from "./Profile/Profile";
import SocialLink from "./SocialLink"


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
class FeedNodeList extends Component {    
    constructor(props) {
        super(props);
        
        this.state = {
            socialLink: "all"
        }
    }
    handleSocialFilter = (socialLink) => {
        if (this.state.socialLink === socialLink) {
            socialLink = "all";
        }
        this.setState({socialLink})
    }

    render() {
        let profile = this.props.profile;

        if (!profile) return <p>There are no profiles</p>;

        let query_variable = {id: parseInt(profile.id)}
        return (
            <div className="container feed-view">
                <div className="row mb-4">
                    <div className="col-sm-10 col-md-8 mx-auto">
                        <Profile profile={profile}/>
                    </div>
                </div>
                <div className="align-items-baseline d-flex flex-nowrap flex-row mb-4 row">
                    <div className="col-6 text-capitalize">
                        <p className="text-white mb-0">latest feed</p>
                    </div>
                    <div className="col-6 text-right social-link__filter">
                        <a className={this.state.socialLink === "1" ? " active" : ""} onClick={() => this.handleSocialFilter("1")}><SocialLink name={"github"}/></a>
                        <a className={this.state.socialLink === "2" ? " active" : ""} onClick={() => this.handleSocialFilter("2")}><SocialLink name={"twitter"}/></a>
                    </div>
                </div>
                <div className="row">
                    <div className="col-md-8 mx-auto">
                        <Query query={GET_PROFILE_FEEDNODES}
                            variables={query_variable}>
                            {({ data, loading, error}) => {
                                if(loading) return <p>Fetching data</p>;
                                if(error) return <p>error</p>;
                                return <FeedNodeQuery 
                                            data={data} 
                                            selectedSocialLink={this.state.socialLink}/>
                            }}
                        </Query>
                    </div>
                </div>
            </div> 
        );
    }
    
};

export default FeedNodeList 