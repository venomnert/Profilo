import React, { Component } from "react";

class Twitter extends Component {
    constructor(props) {
        super(props);

        this.state = {
            id: null
        }
    }
    componentDidMount() 
    { 
        fetch('/api/auth/twitter', {
            headers: { "Content-Type": "application/json; charset=utf-8" },
            method: 'GET'
        })
        .then(res => res.json())
        .then((data) => {
            console.log("Starting SocialLink Twitter", this.state.result);
            this.setState({id: data.id});
        })
    }
    componentDidUpdate() 
    { 
        console.log("Updated SocialLink twitter", this.state.id);
    }
    render() {
        return (
            <li className="social-list__item">
                Twitter is {
                    this.state.id === null ?
                    " not setup":
                    JSON.stringify(this.state.id.data[0].created_at)
                }
            </li>
        );
    }
    
}

export default Twitter;
