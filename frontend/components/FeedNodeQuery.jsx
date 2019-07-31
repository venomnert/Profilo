import React from "react";
import SocialLink from "./SocialLink"
import FeedNode from "./FeedNode"

const FeedNodeQuery = ({data, selectedSocialLink}) => {
    if(!data) return <p>no feed nodes</p>;
    let feed_nodes = data.feedNodes;
    return feed_nodes.map(feed_node => {
            if(selectedSocialLink === feed_node.socialLinkId || selectedSocialLink === "all") {
                return (<FeedNode 
                    key={feed_node.id} 
                    feed_node={feed_node}/>)
            }
        });
}

export default FeedNodeQuery 