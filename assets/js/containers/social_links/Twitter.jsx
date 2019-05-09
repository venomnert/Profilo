import React, { Component } from "react";

class Twitter extends Component {
    constructor(props) {
        super(props);

        this.state = {
            result: null
        }
    }
    render() {
        var result = null;
        fetch('/api/twitter', {
            headers: { "Content-Type": "application/json; charset=utf-8" },
            method: 'GET'
        })        
        .then(res => res.json())
        .then((data) => {
            if(data != null) {
                this.setState({result: data});
            }
        })
        console.log("twitter", this.state.result);
        return (
            <li className="social-list__item">
                Twitter is not setup{
                    this.state.result === null ?
                    " not":
                    Object.keys(this.state.result)[0]
                }
            </li>
        );
    }
}

export default Twitter;
