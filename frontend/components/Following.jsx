import React,{ Component }from "react";
import Draggable from 'react-draggable';
import SocialLink from "./SocialLink"

class Following extends Component {
    renderFollowing = (following) => {
        const {avatarUrl, id, name, screenName, socialLinkId} = following;

        return (
            <div className="following">
                <img className="profile__avatar p-2" src={avatarUrl} alt={screenName} />
                <p className="following__name mb-0">{name}</p>
                <p className="following__name mb-0">@{screenName}</p>
                <SocialLink id={socialLinkId}/>
            </div>
        )
    }
    render() {
        if (!this.props.following) return <div>no followers</div>;
        else if(this.props.draggable) {
           return(
                <Draggable >
                    {this.renderFollowing(this.props.following)}
                </Draggable>
           )
        }
        else { return this.renderFollowing(this.props.following); }   
    }
}
export default Following;
