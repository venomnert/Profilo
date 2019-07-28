import React, { Component, Fragment } from "react";
import SocialLinkList from '../components/SocialLinkList';

export default class Root extends Component {
  constructor(props) {
    super(props);

    this.state = {
      followings: {},
      profiles: {},
      socialLinks: {}
    }
  }
  componentWillMount() {
    this.setState({
      followings: this.props.data.followings,
      profiles: this.props.data.profiles,
      socialLinks: this.props.data.socialLinks
    })
  }
  render() {
    return (
      <Fragment>
        <h2>Welcome</h2>
        <SocialLinkList socialLinks={this.state.socialLinks} />
      </Fragment>
    )        
  }
}