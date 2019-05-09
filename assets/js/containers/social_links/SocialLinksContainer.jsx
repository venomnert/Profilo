import React, { Component } from "react";

// Import Presentational Components
import Github from "./Github"
import Twitter from "./Twitter"


class SocialLinksContainer extends Component {
    constructor(props) {
        super(props);
    }
    render() {
        return (
            <div className="social-menu">
                <ul className="social-list">
                    <Github />
                    <Twitter />
                </ul> 
            </div>
        );
    }
}

export default SocialLinksContainer;
