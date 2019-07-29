import React, { Component } from "react";
import gql from "graphql-tag";
import {Mutation} from "react-apollo";

const CREATE_PROFILE = gql `
  mutation CreateProfile($profile: ProfileInput!) {
    createProfile(input: $profile) {
      name
      avatarUrl
      id
    }
  }
`;

class CreateProfileInput extends Component {
    constructor(props) {
        super(props)
        this.state = {
            profile: {
                name: "",
                avatarUrl: ""    
            }
        }
    }
    handleChange = (e) => {
        const profile = Object.assign(
                            {...this.props.profile},
                            {[e.currentTarget.name]: e.currentTarget.value,
                            avatarUrl: "https://images.unsplash.com/photo-1564324635768-3d9b802cb669?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&w=460&q=460"})

        this.setState({profile})
    }
    render() {
        return (
            <Mutation mutation={CREATE_PROFILE} 
                      variables={this.state}
                      onCompleted={this.props.createProfile}>
                {(create, {loading, error}) => {
                    if(loading) return <p>Loading</p>
                    if(error) return <p>Error</p>
                    return (
                        <form className="profileCreate col-12" onSubmit={e => {
                            e.preventDefault();
                            create();
                            this.setState({
                                profile: {name: "", avatarUrl: ""}
                            })
                        }}>
                            <input
                                type="text"
                                name="name"
                                onChange={this.handleChange}
                                value={this.state.profile.name}
                            />
                        </form>
                    )
                }}
            </Mutation>
        )
    }
}
export default CreateProfileInput;
