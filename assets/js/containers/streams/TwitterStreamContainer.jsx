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
    .then((res_data) => {
      if(res_data != null) {
        this.setState({result: JSON.parse(res_data.data)});
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
        <div class="twitter-data">
          Twitter needs to be setup, see social-links
        </div>
      ); 
    }
    else {
      return (
        <div class="twitter-data">
          <TwitterStream data={this.state.result}/>
        </div>
      );
    }
  }
}

export default TwitterStreamContainer;
