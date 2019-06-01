import React, { Component } from "react";

// Import Presentational Components

class TwitterStream extends Component {
    constructor(props) {
        super(props);

        this.state = {
            user: {}
        }

    }
    render() {
        let item = <li>nothing</li>
        item = this.props.data.data.map(obj => {
            let name = obj.user.name;
            let tweet = obj.text
            let url = obj.user.url+""
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
