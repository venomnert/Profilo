import React, { Component } from "react";

// Import Presentational Components
import Navbar from "./Navbar"
import StreamsContainer from "../streams/StreamsContainer"
import SocialLinksContainer from "../social_links/SocialLinksContainer"


class DashboardContainer extends Component {
    render() {
        return (
            <div>
                <Navbar />
                <SocialLinksContainer />
                <StreamsContainer />
            </div>
        );
    }
}

export default DashboardContainer;
