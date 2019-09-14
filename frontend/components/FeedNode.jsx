import React from "react";

const FeedNode = (props) => {
    const feed_nodes = props.data;
    console.log("INSIDE", feed_nodes);
    if(!feed_nodes) return <p>no feed</p>;
    const feed_node_items = feed_nodes.map(feed_node => {
        return (
            <div key={feed_node.id} className="feed-node">
                <p className="text-white">{feed_node.description}</p>
            </div> 
        );
    });
    return feed_node_items;
}

export default FeedNode 