import React, { Component } from "react";
import twitter_follower_data from "./mock_data/twitter_followers";

import Profiles from "./ui_elements/profiles";
import Social_Links from "./ui_elements/social_links";
import FollowersList from "./ui_elements/followers/FollowersList";
import FollowerItem from "./ui_elements/followers/FollowerItem";

export default class Root extends Component {
  constructor(props) {
    super(props);

    this.state = {
      social_links: {
        github: {
          followers: []
        },
        twitter: {
          followers: []
        }
      }
    }
  }
  componentDidMount() {
    const twitter_data = twitter_follower_data.data.users;
    const social_links = Object.assign(
                    {...this.state.social_links},
                    {twitter: {followers: twitter_data}})
    
    this.setState({social_links});
  }
  render() {
    return (
      <div className="container">
        <div className="row">
          <h2>Profiles</h2>
          <Profiles />
        </div>

        <div className="row">
          <h2>Followers</h2>
          <FollowersList social_links={this.state.social_links}/>
        </div>
        
        <div className="row">
          <h2>Connect Social Links</h2>
          <Social_Links />
        </div>
      </div>
    )        
  }
}