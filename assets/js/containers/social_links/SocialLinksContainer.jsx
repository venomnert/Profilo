import React, { Component } from "react";

// Import Presentational Components
import Github from "./Github"


class SocialLinksContainer extends Component {
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
            <div className="social-menu">
                <ul className="social-list"> 
                    <Github />
                </ul> 
            </div>
        );
    }
}

export default SocialLinksContainer;
