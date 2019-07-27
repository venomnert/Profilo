import React, { Component } from "react";

// Import Presentational Components
import GithubStreamContainer from './GithubStreamContainer'
import TwitterStreamContainer from './TwitterStreamContainer'

class StreamsContainer extends Component {
    constructor(props) {
        super(props);

        this.state = {
            user: {}
        }

    }
    render() {
        return (
            <div>
                <h1>This will be streams</h1>
                <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                    <li class="nav-item">
                    <a class="nav-link active" id="pills-github-tab" data-toggle="pill" href="#pills-github" role="tab" aria-controls="pills-github" aria-selected="true">Github</a>
                    </li>
                    <li class="nav-item">
                    <a class="nav-link" id="pills-twitter-tab" data-toggle="pill" href="#pills-twitter" role="tab" aria-controls="pills-twitter" aria-selected="false">Twitter</a>
                    </li>
                </ul>
                <div class="tab-content" id="pills-tabContent">
                    <div class="tab-pane fade show active" id="pills-github" role="tabpanel" aria-labelledby="pills-github-tab">
                        <GithubStreamContainer/>
                    </div>
                    <div class="tab-pane fade" id="pills-twitter" role="tabpanel" aria-labelledby="pills-twitter-tab">
                        <TwitterStreamContainer/>
                    </div>
                </div>
            </div>
        );
    }
}

export default StreamsContainer;
