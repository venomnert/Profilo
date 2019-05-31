import React, { Component } from "react";

class Twitter extends Component {
    constructor(props) {
        super(props);

        this.state = {
            result: null
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
            if(data != null) {
                console.log("Starting SocialLink Twitter", this.state.result);
                this.setState({result: data});
            }
        })
    }
    componentDidUpdate() 
    { 
        console.log("Updated SocialLink twitter", this.state.result);
    }
    render() {
        return (
            <li className="social-list__item">
                Twitter is {
                    this.state.result === null ?
                    " not setup":
                    JSON.stringify(this.state.result.data[0].created_at)
                }
            </li>
        );
    }
    
}

export default Twitter;
