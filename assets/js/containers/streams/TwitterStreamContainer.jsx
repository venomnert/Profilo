import React, { Component } from "react";

import TwitterStream from "./TwitterStream";

class TwitterStreamContainer extends Component {
  constructor(props) {
    super(props);

    this.state = {
      result: []
    }
  }
  componentDidMount() 
  { 
    fetch('/api/twitter', {
      headers: { "Content-Type": "application/json; charset=utf-8" },
      method: 'GET'
    })        
    .then(res => {
      if (res.status === 404) {
        this.setState({result: []});
        return;
      }
      return res.json()
    })
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
    if (this.state.result.length <= 0) {
      return (
        <div>
          <div class="twitter-data">
            Login into twitter
          </div>
        </div>
      ); 
    }
    else {
      return (
        <div>
          <div class="twitter-data">
            
            <TwitterStream data={this.state.result}/>
          </div>
        </div>
      );
    }
  }
}

export default TwitterStreamContainer;
