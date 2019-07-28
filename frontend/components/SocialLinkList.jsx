import React from "react";
import SocialLink from "./SocialLink"

const SocialLinkList = ({socialLinks}) => (
    socialLinks.map(social_link => {
        return <SocialLink 
                    key={social_link.id}
                    name={social_link.name} 
                    id={social_link.id}/>
    })
);

export default SocialLinkList 