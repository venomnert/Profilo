import React, { Component } from "react";
import gql from "graphql-tag";
import {Query} from "react-apollo";

const REPOSITORIES = gql`
{
  viewer{
      name
  }
}
`; 

class Github extends Component {
    constructor(props) {
        super(props);

        this.state = {
            id: null
        }
    }
    componentDidMount() 
    { 
        fetch('/api/auth/github', {
            headers: { "Content-Type": "application/json; charset=utf-8" },
            method: 'GET'
        })
        .then(res => res.json())
        .then((data) => {
            // console.log("Starting SocialLink Github", this.state.result);
            this.setState({id: data.id});
        })
    }
    componentDidUpdate() 
    { 
        // console.log("Updated SocialLink Github", this.state.id);
    }
    render() {
        let error_item = <li className="social-list__item"><a href="/auth/github/new">Github needs to be setup</a></li>
        if (this.state.id === null) {
            return(error_item);
        }
        else {
            return (
                <Query query={REPOSITORIES}>
                    {({loading, error, data}) => {
                        if(error) {return(error_item);}
                        else {return(<li className="social-list__item"> Github is setup</li>)}
                    }}
                </Query>
            );
        }
    }
}

export default Github;
