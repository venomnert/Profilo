import React, { Component } from "react";

class GithubStream extends Component {
    constructor(props) {
        super(props);

        this.state = {
            user: {}
        }

    }
    render() {
        let item = this.props.data.following.edges.map(obj => {
            let name = obj.node.name;
            let url = obj.node.url+"";
            let repo = obj.node.repositories.edges[0].node.name
            let watching = obj.node.starredRepositories.edges[0].node.name
            return (<li>
                <div>
                    <a href={url}>{name}</a>
                    <p>Repo Name: {repo}</p>
                    <p>Watching: {watching}</p>
                </div>
            </li>);
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

export default GithubStream;
