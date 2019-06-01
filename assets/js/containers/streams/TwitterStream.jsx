import React, { Component } from "react";

// Import Presentational Components

class TwitterStream extends Component {
    constructor(props) {
        super(props);
    }
    render() {
        let item = <li>nothing</li>
        item = Object.keys(this.props.data).map(id => {
            let obj_data = this.props.data[id];
            let name = obj_data.user.name;
            let tweet = obj_data.text
            let url = obj_data.user.url+""
            return (
                <li>
                    <p><a href={url}>{name}</a></p>
                    <p>{tweet}</p>
                </li>
            );
        });
        return (
            <div>
                <ul>
                    {item}
                </ul>
            </div>
        );
    }
}

export default TwitterStream;
