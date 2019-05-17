import React, { Component } from "react";

import TwitterStream from "./TwitterStream";

class TwitterStreamContainer extends Component {
  constructor(props) {
    super(props);

    this.state = {
      result: null
    }
  }
  componentDidMount() 
  { 
    fetch('/api/twitter', {
      headers: { "Content-Type": "application/json; charset=utf-8" },
      method: 'GET'
    })        
    .then(res => res.json())
    .then((data) => {
      if(data != null) {
        console.log("Starting Twitter", this.state.result);
        this.setState({result: data});
      }
    })
  }
  componentDidUpdate() 
  { 
    console.log("Updated twitter", this.state.result);
  }
  render() {
    return (
      <div>
        <div class="twitter-data">
          <TwitterStream data={this.state.result}/>
        </div>
      </div>
    );
  }
}

export default TwitterStreamContainer;
