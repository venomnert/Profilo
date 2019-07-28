import React, { Component } from "react";
import Profile from "./Profile";
import ProfilePreviewItem from "./ProfilePreviewItem";
import CreateProfileInput from "./CreateProfileInput";

class ProfilesList extends Component {
    render() {
        let profiles = this.props.profiles;
        return (
            <div className="col-12 profilesList">
                <h2>Profile Entity</h2>
                <ul className="list-unstyled">
                    {
                        profiles.map(profile => {
                            return (
                                <li key={profile.id}>
                                    <Profile profile={profile} />
                                </li>
                            )
                        })
                    }
                </ul>
                <h2>Profile Preview Item</h2>
                <ul className="list-unstyled">
                    {
                        profiles.map(profile => {
                            return (
                                <li key={profile.id}>
                                    <ProfilePreviewItem profile={profile} />
                                </li>
                            )
                        })
                    }
                </ul>
                <h2>Profile Create</h2>
                <CreateProfileInput createProfile={this.props.createProfile}/>

                <h2>Profile Edit</h2>
            </div>
        );
    }
}
export default ProfilesList;
