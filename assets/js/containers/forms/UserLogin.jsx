import React, { Component } from "react";

// Import Presentational Components
import Input from "../../components/Input"
import Button from "../../components/Button"

class UserLogin extends Component {
    constructor(props) {
        super(props);

        this.state = {
            user: {
                email: '',
                password: ''
            }
        }

        this.handleFormSubmit = this.handleFormSubmit.bind(this);
        this.handleClearForm = this.handleClearForm.bind(this);
        this.handleEmail = this.handleEmail.bind(this);
        this.handlePassword = this.handlePassword.bind(this);
    }
    handleFormSubmit(e) {
        e.preventDefault();
        let userData = this.state.user;         
       
        fetch('/api/v1/sign-in', {
            method: "POST",
            body: JSON.stringify(userData),
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            }
        }).then(res => {
            res.json().then(data => {
                console.log("Successful", data);
                this.handleClearForm();
            })
        })
    }
    handleClearForm(e) {
        this.setState({
            user: {
                email: '',
                password: ''
            }
        })
    }
    handleEmail(e){
        let value = e.target.value
        let newState = Object.assign(this.state.user, {email: value});
        this.setState(prevState => newState);
    }
    handlePassword(e){
        let value = e.target.value
        let newState = Object.assign(this.state.user, {password: value});
        this.setState(prevState => newState);
    }
    render() {
        return (
            <form className="form-container--user-login" onSubmit={this.handleFormSubmit}>
                <Input 
                    title={"Email"}
                    id={"email"}
                    name={"Email"}
                    type={"email"}
                    value={this.state.user.email}
                    handleChange={this.handleEmail}
                    placeholder={"Enter your email"}
                />
                <Input 
                    title={"Password"}
                    id={"password"}
                    name={"Password"}
                    type={"password"}
                    value={this.state.user.password}
                    handleChange={this.handlePassword}
                    placeholder={"Enter your password"}
                />
                <Button 
                    title={"Login"}
                    action={this.handleFormSubmit}
                />
            </form>
        );
    }
}

export default UserLogin;