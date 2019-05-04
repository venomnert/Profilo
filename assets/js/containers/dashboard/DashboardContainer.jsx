import React, { Component } from "react";

// Import Presentational Components
import Navbar from "./Navbar"
import StreamsContainer from "../streams/StreamsContainer"
import SocialLinksContainer from "../social_links/SocialLinksContainer"


class DashboardContainer extends Component {
    constructor(props) {
        super(props);

        this.state = {
            user: {
                email: '',
                password: '',
                password_confirmation: '',
                first_name: '',
                last_name: '',
                address: '',
                company: '',
                phone_number: '',
                website: ''
            }
        }

    }
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
