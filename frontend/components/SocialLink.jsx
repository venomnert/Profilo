import React, { Component } from "react";

import TwitterIcon from '../static/icons/Twitter.svg';
import GithubIcon from '../static/icons/Github.svg';

class SocialLink extends Component {
    render() {
        if(this.props.name === "github" || this.props.id == "1") {
            return (
                <div className="social-link social-link--github" data-social-link="github">
                    <GithubIcon width="40px" height="40px" />
                </div>
            )
        }
        else {
            return (
                <div  className="social-link social-link--twitter" data-social-link="twitter">
                    <TwitterIcon width="40px" height="40px"/>
                </div>
            )
        }
    }
}
export default SocialLink 