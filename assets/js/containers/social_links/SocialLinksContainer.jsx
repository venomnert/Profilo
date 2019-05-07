import React, { Component } from "react";
import gql from "graphql-tag";
import {Query} from "react-apollo";

// Import Presentational Components
import Github from "./Github"

const REPOSITORIES = gql`
{
  viewer{
      name
  }
}
`; 

class SocialLinksContainer extends Component {
    constructor(props) {
        super(props);

        this.state = {
            user: {
                email: '',
                password: '',
                password_confirmation: '',
                first_name: '',
                last_name: '',
                address: '',
                company: '',
                phone_number: '',
                website: ''
            }
        }
    }
    render() {
        return (
            <div className="social-menu">
                <ul className="social-list">
                <Query query={REPOSITORIES}>
                    {({loading, error, data}) => {
                        console.log("loading", loading)
                        console.log("error", error)
                        console.log("data", data)
                        if(error) return(<Github />);
                        return(<div class="github-data">Github is setup</div>)
                    }}
                </Query> 
                </ul> 
            </div>
        );
    }
}

export default SocialLinksContainer;
