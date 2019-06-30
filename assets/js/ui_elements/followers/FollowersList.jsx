import React, { Component } from "react";

import FollowerItem from "./FollowerItem";

class FollowersList extends Component {
    render() {
        let social_links = this.props.social_links;
        return (
            <div className="followersList">
                <ul>
                    {
                        Object.keys(social_links).map(social_link => {
                            if (social_links[social_link].followers.length > 0) {
                                return social_links[social_link].followers.map(user => {
                                    return (
                                        <li key={user.id}>
                                            <FollowerItem 
                                                draggable={false}
                                                social_link={social_link}
                                                id={user.id} 
                                                user={user} />
                                        </li>
                                    )
                                })
                            }
                        })
                    }
                </ul>
            </div>
        );
    }
}

export default FollowersList;
