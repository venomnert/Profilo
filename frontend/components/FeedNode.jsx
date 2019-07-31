import React, {Fragment} from "react";
import SocialLink from "./SocialLink"

const FeedNode = ({data}) => {
    if(!data) return <p>no feed</p>;
    let feed_nodes = data.feedNodes;
    return feed_nodes.map(feed_node => (
                <Fragment key={feed_node.id}>
                    <p>{feed_node.description}</p>
                    <SocialLink id={feed_node.socialLinkId}/>
                </Fragment> 
            ));
}

export default FeedNode 