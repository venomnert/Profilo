import React, { Component } from "react";

class GithubStream extends Component {
    constructor(props) {
        super(props);

        this.state = {
            user: {}
        }

    }
    render() {
        // console.log("THIS IS THE ERROR" , this.props.data);
        let item = this.props.data.following.edges.map(obj => {
            console.log("oject structure" , obj);
            let name = obj.node.name;
            let url = obj.node.url+"";
            let repo = obj.node.repositories.edges[0].node.name;
            let watch = "no watching";
            if (obj.node.starredRepositories.edges.length > 0) {
                watch = obj.node.starredRepositories.edges[0].node.name;
            }
            return (<li>
                <div>
                    <a href={url}>{name}</a>
                    <p>Repo Name: {repo}</p>
                    <p>Watching: {watch}</p>
                </div>
            </li>);
        });
        console.log("This is the item list " , item);
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
