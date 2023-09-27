import React from 'react';
import { appPoke, patpShorten, isRemoteGroup } from "~/lib";
import { OUR } from "~/const";

export default function SelectChats({
  chats,
  viewSelect,
  setView,
}) {

  const handleNew = () => {
      appPoke({
        "new": {
          "chat" : {"id": "1", "name": "wtf"},
          "msgs" : [{"who": "system", "what":"you are a chat bot"}]
        }
      });
  };

  const handleView = (newView) => {
    console.log('handleview', newView)
    setView(newView);
  };

  return (
    <div className="top-bar">
      <select
        onChange={e => handleView(e.target.value)}
        value={viewSelect}>
        <option value="def">Chats</option>
        {[...chats.keys()].map((chat,i) => 
          <option key={i} value={chat}>{chat}
          </option>
        )}
      </select>
      <div>
          <a className='join-button' onClick={handleNew}>
          New
        </a>
      </div>
    </div>
  );
}
