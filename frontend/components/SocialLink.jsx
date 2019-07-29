import React, { Component } from "react";

import TwitterIcon from '../static/icons/Twitter.svg';
import GithubIcon from '../static/icons/Github.svg';

class SocialLink extends Component {
    render() {
        if(this.props.name === "github" || this.props.id == "1") return <GithubIcon width="40px" height="40px" className="fill-primary"/>;
        return <TwitterIcon width="40px" height="40px" className="fill-primary" />
    }
}
export default SocialLink 