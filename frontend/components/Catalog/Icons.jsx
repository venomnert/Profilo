import React from 'react';

import CloseIcon from './icons/Close.svg';
import ProfileIcon from './icons/Profile.svg';
import SettingsIcon from './icons/Settings.svg';
import PlusIcon from './icons/Plus.svg';


const Icons = () => {
    return (
        <>
            <CloseIcon width="40px" height="40px" className="fill-primary" />
            <ProfileIcon width="40px" height="40px" className="fill-primary" />
            <SettingsIcon width="40px" height="40px" className="fill-primary" />
            <PlusIcon width="40px" height="40px" className="fill-primary" />
        </>
    )
}

export default Icons;