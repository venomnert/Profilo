import React, { Component } from "react";

import Profile from "./Profile";
import ProfilePreviewItem from "./ProfilePreviewItem";
// import ProfileListItem from "./ProfileListItem";

class ProfilesList extends Component {
    render() {
        let profiles = this.props.profiles;
        return (
            <div className="col-12 profilesList">
                <h2>Profile Entity</h2>
                <ul className="list-unstyled">
                    {
                        Object.keys(profiles).map(id => {
                            return (
                                <li key={id}>
                                    <Profile id={id} profile={profiles[id]} />
                                </li>
                            )
                        })
                    }
                </ul>
                <h2>Profile Preview Item</h2>
                <ul className="list-unstyled">
                    {
                        Object.keys(profiles).map(id => {
                            return (
                                <li key={id}>
                                    <ProfilePreviewItem id={id} profile={profiles[id]} />
                                </li>
                            )
                        })
                    }
                </ul>
                <h2>Profile List Item</h2>
                <ul className="list-unstyled">
                    {
                        Object.keys(profiles).map(id => {
                            return (
                                <li key={id}>
                                    {/* <ProfileListItem id={id} profile={profiles[id]} /> */}
                                </li>
                            )
                        })
                    }
                </ul>
            </div>
        );
    }
}
export default ProfilesList;
