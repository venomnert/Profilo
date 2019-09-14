import React, { Component, Fragment, useState } from "react";
import SocialLinkList from './SocialLinkList';
import ProfilesList from './Profile/ManageProfilesList';
import Menu from  './Menu'
import FeedNodeList from "./FeedNodeList";
//import FollowingList from "./FollowingList";
import { Link } from 'react-router-dom';
import { NavLink } from 'react-router-dom';


// const Root = (props) => {
  
//   const [followings, setFollowings] = useState(props.data.followings);
//   const [profiles, setProfiles] = useState(props.data.profiles);
//   const [socialLinks, setSocialLinks] = useState(props.data.socialLinks);

//   console.log(followings)
//   console.log(profiles)
//   console.log(socialLinks)

  
// return(
//     <>
//       <h1> Root.jsx </h1>
//       <NavLink to="/menu">Menu</NavLink>
//     </> 
//   )
// }

// export default Root;


export default class Root extends Component {

  constructor(props) {
    console.log("Root");
    console.log(props)
    super(props);

    this.state = {
      followings: {},
      profiles: {},
      socialLinks: {},
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
      //update only the profile that matches the profile that needs to be updated
      if(profile.id === data.updateProfile.id) {
        return data.updateProfile;
      }
      return profile
    });
    this.setState({profiles: update_profile_state});
  }

  componentWillMount() {
    console.log(this.props)

    this.setState({
      followings: this.props.data.data.followings,
      profiles: this.props.data.data.profiles,
      socialLinks: this.props.data.data.socialLinks
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
        <h2>Root.jsx</h2>
        <NavLink to="/menu">Menu</NavLink>
        {/* <Menu/> */}
        {/* <SocialLinkList socialLinks={this.state.socialLinks} /> */}
         {/* <ProfilesList 
          profiles={this.state.profiles} 
          createProfile={this.createProfile}
          updateProfile={this.updateProfile}/> */}
          
        {/* <FeedNodeList profile={this.state.profiles[4]} />  */}
        {/* <Link to="/app/:proile">Profile</Link> */}

      </Fragment>
    )        
  }
}