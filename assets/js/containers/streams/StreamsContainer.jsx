import React, { Component } from "react";

// Import Presentational Components


class StreamsContainer extends Component {
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
                <h1>This will be streams</h1>
            </div>
        );
    }
}

export default StreamsContainer;
