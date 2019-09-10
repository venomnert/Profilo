import React,{ Component }from "react";
import SocialLink from "./SocialLink"
import { useDrag } from 'react-dnd'

/*  
    Individual Followings
*/

const Following = (props) => {
    const renderFollowing = (following) => {
        const {avatarUrl, id, name, screenName, socialLinkId} = following;
        const type = "following"
        const [{ opacity }, drag] = useDrag({
            item: { id, type },
            collect: monitor => ({
              opacity: monitor.isDragging() ? 0.1 : 1,
            }),
          })

        return (
            <div ref={drag} className="following">
                <img className="profile__avatar p-2" src={avatarUrl} alt={screenName} />
                <p className="following__name mb-0">{name}</p>
                <p className="following__name mb-0">@{screenName}</p>
                <SocialLink id={socialLinkId}/>
            </div>
        )
    }

    if (!props.following) return <div>no followers</div>;
    else { return renderFollowing(props.following); }
}

export default Following;
