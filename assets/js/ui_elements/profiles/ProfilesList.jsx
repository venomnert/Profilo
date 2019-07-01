import React, { Component } from "react";

import ProfileItem from "./ProfileItem";

class ProfilesList extends Component {
    render() {
        let profiles = this.props.profiles;
        return (
            <div className="profilesList">
                <ul>
                    {
                        Object.keys(profiles).map(id => {
                            return (
                                <li key={id}>
                                    <ProfileItem 
                                        id={id} 
                                        profile={profiles[id]} />
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
