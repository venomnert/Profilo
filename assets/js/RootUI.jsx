import React, { Component } from "react";
import twitter_follower_data from "./mock_data/twitter_followers";
import github_follower_data from "./mock_data/github_followers";
import profiles_data from "./mock_data/profiles_data";

import ProfilesList from "./ui_elements/profiles/ProfilesList";
import ProfileEdit from "./ui_elements/profiles/ProfileEdit";

import Social_Links from "./ui_elements/social_links";
import FollowersList from "./ui_elements/followers/FollowersList";

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
      },
      profiles: {}
    }
  }
  componentDidMount() {
    const twitter_data = twitter_follower_data.data.users;
    const github_data = github_follower_data.data.viewer.following.edges;
    const social_links = Object.assign(
                    {...this.state.social_links},
                    {
                      github: {followers: github_data},
                      twitter: {followers: twitter_data}
                    })

    const profiles = Object.assign(
                      {...this.state.profiles},
                      profiles_data);

    const new_state = Object.assign(
                      {...this.state},
                      {
                        profiles,
                        social_links
                      })
    this.setState({...new_state});
  }
  update_profile = (id, update_profile) => {
    const profiles = Object.assign(
                      {...this.state.profiles},
                      {[id]: update_profile});
    this.setState({profiles});
  }
  delete_profile = (id) => {
    const profiles = Object.keys(this.state.profiles)
                      .filter(curr_id => curr_id !== id)
                      .reduce((new_profile, key) => {
                        new_profile[key] = this.state.profiles[key]
                        return new_profile;
                      }, {});

    this.setState({profiles});
  }
  render() {
    return (
      <div className="container">
        <div className="row">
          <h2>Profiles</h2>
          <ProfilesList profiles={this.state.profiles}/>
          
          <h2>Edit Profile</h2>
          <ProfileEdit 
              update_profile={this.update_profile}
              delete_profile={this.delete_profile}
              id="someuniqueid_1" 
              profile={this.state.profiles["someuniqueid_1"]}/>
        </div>

        <div className="row">
          <h2>Followers</h2>
          <div className="col-12">
            <FollowersList social_links={this.state.social_links}/>
          </div>
        </div>
        
        <div className="row">
          <h2>Connect Social Links</h2>
          <Social_Links />
        </div>
      </div>
    )        
  }
}