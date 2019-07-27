import React, { Component } from "react";
import TwitterIcon from '../icons/Twitter.svg';
import GithubIcon from '../icons/Github.svg';

class Social_Link extends Component {
    render() {
        return (
            <div>
                <TwitterIcon width="40px" height="40px" />
                <GithubIcon width="40px" height="40px" />
            </div>
        );
    }
}
export default Social_Link;
