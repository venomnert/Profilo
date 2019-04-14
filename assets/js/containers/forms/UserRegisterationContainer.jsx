import React, { Component } from "react";

// Import Presentational Components
import Input from "../../components/Input"
import Button from "../../components/Button"

class UserRegisterationContainer extends Component {
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
            },
            password_validation: true
        }

        this.handleFormSubmit = this.handleFormSubmit.bind(this);
        this.handleClearForm = this.handleClearForm.bind(this);
        this.handleFirstName = this.handleFirstName.bind(this);
        this.handleLastName = this.handleLastName.bind(this)
        this.handleEmail = this.handleEmail.bind(this)
        this.handlePassword = this.handlePassword.bind(this)
        this.handlePasswordConfirmation = this.handlePasswordConfirmation.bind(this) 
        this.handleAddress = this.handleAddress.bind(this)
        this.handleCompany = this.handleCompany.bind(this) 
        this.handlePhoneNumber = this.handlePhoneNumber.bind(this)
        this.handleWebsite = this.handleWebsite.bind(this) 
    }

    handleFormSubmit(e) {
        e.preventDefault();
        let userData = this.state.user;         
        if (this.state.user.password_confirmation !== this.state.user.password) {
            let newState = Object.assign(this.state, {password_validation: false});
            this.setState(prevState => newState);
            return;    
        }
        else {
            let newState = Object.assign(this.state, {password_validation: true});
            this.setState(prevState => newState);
        }

        fetch('/api/v1/signup', {
            method: "POST",
            body: JSON.stringify({user: userData}),
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
                password: '',
                password_confirmation: '',
                first_name: '',
                last_name: '',
                address: '',
                company: '',
                phone_number: '',
                website: ''
            },
            password_validation: true
        })
    }
    handleFirstName(e) {
        let value = e.target.value
        let newState = Object.assign(this.state.user, {first_name: value});
        this.setState(prevState => newState);
    }
    handleLastName(e){
        let value = e.target.value
        let newState = Object.assign(this.state.user, {last_name: value});
        this.setState(prevState => newState);
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
    handlePasswordConfirmation(e){
        let value = e.target.value
        let newState = Object.assign(this.state.user, {password_confirmation: value});
        this.setState(prevState => newState);
    }
    handleAddress(e){
        let value = e.target.value
        let newState = Object.assign(this.state.user, {address: value});
        this.setState(prevState => newState);
    }
    handleCompany(e){
        let value = e.target.value
        let newState = Object.assign(this.state.user, {company: value});
        this.setState(prevState => newState);
    } 
    handlePhoneNumber(e){
        let value = e.target.value
        let newState = Object.assign(this.state.user, {phone_number: value});
        this.setState(prevState => newState);
    }
    handleWebsite(e){
        let value = e.target.value
        let newState = Object.assign(this.state.user, {website: value});
        this.setState(prevState => newState);
    } 

    render() {
        return (
            <form className="form-container--user-registeration" onSubmit={this.handleFormSubmit}>
                <Input 
                    title={"First Name"}
                    id={"first-name"}
                    name={"First Name"}
                    type={"text"}
                    value={this.state.user.first_name}
                    handleChange={this.handleFirstName}
                    placeholder={"Enter your first name"}
                />
                <Input 
                    title={"Last Name"}
                    id={"last-name"}
                    name={"Last Name"}
                    type={"text"}
                    value={this.state.user.last_name}
                    handleChange={this.handleLastName}
                    placeholder={"Enter your last name"}
                />
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
                <Input 
                    className={this.state.password_validation? "": "invalid-input"}
                    title={"Password Confirmation"}
                    id={"password-confirmation"}
                    name={"Password Confirmation"}
                    type={"password"}
                    value={this.state.user.password_confirmation}
                    handleChange={this.handlePasswordConfirmation}
                    placeholder={"Re-enter your password"}
                />
                <Input 
                    title={"Address"}
                    id={"address"}
                    name={"Address"}
                    type={"text"}
                    value={this.state.user.address}
                    handleChange={this.handleAddress}
                    placeholder={"Enter your address"}
                />
                <Input 
                    title={"Company"}
                    id={"company"}
                    name={"Company"}
                    type={"text"}
                    value={this.state.user.company}
                    handleChange={this.handleCompany}
                    placeholder={"Company name"}
                />
                <Input 
                    title={"Phone Number"}
                    id={"phone-number"}
                    name={"Phone Number"}
                    type={"number"}
                    value={this.state.user.phone_number}
                    handleChange={this.handlePhoneNumber}
                    placeholder={"Enter your phone number"}
                />
                 <Input 
                    title={"Website"}
                    id={"website"}
                    name={"Website"}
                    type={"url"}
                    value={this.state.user.website}
                    handleChange={this.handleWebsite}
                    placeholder={"Enter your Website"}
                />
                <Button 
                    title={"Register"}
                    action={this.handleFormSubmit}
                />
            </form>
        );
    }
}

export default UserRegisterationContainer;
