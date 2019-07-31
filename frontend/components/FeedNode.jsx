import React from "react";
import SocialLink from "./SocialLink"

const FeedNode = ({feed_node}) => {
    if(!feed_node) return <p>no feed</p>;
    return (
        <div key={feed_node.id} className="feed-node">
            <p>{feed_node.description}</p>
            <SocialLink id={feed_node.socialLinkId}/>
        </div> 
    );
}

export default FeedNode 