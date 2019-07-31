import React, { Component, Fragment } from "react";
import SocialLinkList from '../components/SocialLinkList';
import ProfilesList from '../components/Profile/ProfilesList';
import Menu from  '../components/Menu/Menu'
import { BrowserRouter, Route, Switch } from "react-router-dom";
import FeedNodeList from "../components/FeedNodeList";
import FollowingList from "../components/FollowingList";
import CloseIcon from '../static/icons/Close.svg';
import ProfileIcon from '../static/icons/Profile.svg';
import SettingsIcon from '../static/icons/Settings.svg';
import PlusIcon from '../static/icons/Plus.svg';

export default class Root extends Component {
  constructor(props) {
    super(props);

    this.state = {
      followings: {},
      profiles: {},
      socialLinks: {}
    }
  }
  createProfile = (profile) => {
    const profiles = this.state.profiles;
    profiles.push(profile.createProfile);
    this.setState({profiles});
  }
  updateProfile = (data) => {
    console.log(data);
    let update_profile_state = this.state.profiles.map(profile => {
      if(profile.id === data.updateProfile.id) {
        return data.updateProfile;
      }
      return profile
    });
    this.setState({profiles: update_profile_state});
  }
  componentWillMount() {
    this.setState({
      followings: this.props.data.followings,
      profiles: this.props.data.profiles,
      socialLinks: this.props.data.socialLinks
    });

    fetch('/api/github', {
      headers: { "Content-Type": "application/json; charset=utf-8" },
      method: 'GET'
    })
    .then(res => res.json())
    .then((data) => {
        console.log("Starting SocialLink", data);
    })
  }
  render() {
    return (
      <Fragment>
        <h2>Welcome</h2>
        {/* <Menu/> */}
        {/* <SocialLinkList socialLinks={this.state.socialLinks} /> */}
        {/* <ProfilesList 
          profiles={this.state.profiles} 
          createProfile={this.createProfile}
          updateProfile={this.updateProfile}/> */}
          
        <FeedNodeList profile={this.state.profiles[0]} /> 

        <CloseIcon width="40px" height="40px" className="fill-primary" />
        <ProfileIcon width="40px" height="40px" className="fill-primary" />
        <SettingsIcon width="40px" height="40px" className="fill-primary" />
        <PlusIcon width="40px" height="40px" className="fill-primary" />

      </Fragment>
    )        
  }
}