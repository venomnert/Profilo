import React, { Component } from "react";

import gql from "graphql-tag";
import {Mutation} from "react-apollo";

//Miz take a look at the vid on Gdrive/Whatsapp
const UPDATE_PROFILE = gql`
mutation UpdateProfile($id: Int!, $following_ids: [Int]!, $profile: ProfileInput!) {
    updateProfile(id: $id, input: $profile) {
    	name
    	avatarUrl
        id
    }
    linkFollowingToProfile(id: $id, followings: $following_ids) {
      name
      avatarUrl
      followings {
        name
        screenName
      }
    }
}
`
class ProfileEdit extends Component {
    constructor(props) {
        super(props);

        this.state = {
            id: parseInt(this.props.profile.id),
            following_ids: [1,2],
            profile: {
                name: this.props.profile.name,
                avatarUrl: this.props.profile.avatarUrl
            }
        };

        // this.updateProfile = () => { console.log("Mutation completed callback") }
    }

    //update state due to form input
    handleChange = (e) => {
        //update profile's name
            // update profile name
                const profile = Object.assign(
                    {...this.state.profile},
                    {[e.currentTarget.name]: e.currentTarget.value})
        
        //set state
        this.setState({
            id: parseInt(this.props.profile.id),
            profile
        })
    }
    render() {
        return (
            <Mutation mutation={UPDATE_PROFILE}
                      variables={this.state}
                      onCompleted={this.props.updateProfile}>
                {(update, {loading, error}) => {
                    if(loading) return <p>loading</p>;
                    if(error) return <p>error</p>;
                    return (
                        <form className="profileEdit col-12" onSubmit={e => {
                            e.preventDefault();
                            update();
                        }}>
                            <img className="profile__avatar p-2" src={this.state.profile.avatarUrl} alt={this.state.profile.name}/>
                            <input
                                type="text"
                                name="avatarUrl"
                                onChange={this.handleChange}
                                value={this.state.profile.avatarUrl} />
                            <input
                                type="text"
                                name="name"
                                onChange={this.handleChange}
                                value={this.state.profile.name} />
                            <button type="submit">Update Profile</button>
                        </form>
                    )
                }}
            </Mutation>
        );
    }
}
export default ProfileEdit;
