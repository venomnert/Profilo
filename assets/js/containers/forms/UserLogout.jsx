import React, { Component } from "react";

// Import Presentational Components
import Input from "../../components/Input"
import Button from "../../components/Button"

class UserLogout extends Component {
    constructor(props) {
        super(props);

        this.handleFormSubmit = this.handleFormSubmit.bind(this);
    }
    handleFormSubmit(e) {
        e.preventDefault();
       
        fetch('/api/v1/sign-out', {
            method: "POST",
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            }
        }).then(res => {
            res.json().then(data => {
                console.log("Successful", data);
            })
        })
    }
    render() {
        return (
            <form className="form-container--user-logout" onSubmit={this.handleFormSubmit}>
                <Button 
                    title={"Logout"}
                    action={this.handleFormSubmit}
                />
            </form>
        );
    }
}

export default UserLogout;