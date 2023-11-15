import React, { useEffect, useState, useCallback, useRef } from 'react';
import Urbit from '@urbit/http-api';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faPlus, faXmark } from '@fortawesome/free-solid-svg-icons'
import PureModal from 'react-pure-modal';
import 'react-pure-modal/dist/react-pure-modal.min.css';
import api from "./api.js";
import {
  MainContainer,
  ChatContainer,
  MessageList,
  Message,
  MessageInput,
  ConversationList,
  Conversation,
  ConversationHeader,
  Sidebar,
	Status,
  Button
} from "@chatscope/chat-ui-kit-react";
import './themes/default/main.scss';


export function App() {
  const [subEvent, setSubEvent] = useState({});
  const [chats, setChats] = useState(new Map());
  const [conn, setConn] = useState("dnd");
  const [message, setMessage] = useState("");
  const [title, setTitle] = useState("");
  const [prompt, setPrompt] = useState("");
  const [currentChat, setCurrentChat] = useState(null);
  const [sidebarStyle, setSidebarStyle] = useState({});
  const [chatContainerStyle, setChatContainerStyle] = useState({});
  const [conversationContentStyle, setConversationContentStyle] = useState({});
  const [modal, setModal] = useState(false);
	const root = document.documentElement;
	document.body.style = 'background: #5C7060;';
	
  
  const handleBackClick = () => {
    setCurrentChat(null);
    setMessage("");
  };

  const handleConversationClick = useCallback((chat) => {
    if (currentChat === null) {
      setCurrentChat(chat);
    }
  }, [currentChat, setCurrentChat]);

  const handleAddClick = useCallback(() => {
    if (!modal) {
      setModal(true);
    }
  }, [modal, setModal]);

  const handleCloseModal = useCallback(() => {
    setTitle("");
    setPrompt("");
    if (modal) {
      setModal(false);
    }
  }, [modal, setModal]);
  
  const handleDelete = (e, chat) => {
    e.stopPropagation();
    api.poke({
      app: "penpai",
      mark: "penpai-do",
      json: {del: {name: chat}}
    });
  };
  
  const handleCreate = () => {
    api.poke({
      app: "penpai",
      mark: "penpai-do",
      json: {new: {name: title, prompt: prompt}}
    });
    setTitle("");
    setPrompt("");
  };

  const handleSend = () => {
    if (currentChat !== null) {
      api.poke({
        app: "penpai",
        mark: "penpai-do",
        json: {post: {name: currentChat, who: "user", what: message}}
      });
    };
    setMessage("");
  };

  useEffect(() => {
    const subscription = api.subscribe({
      app: "penpai",
      path: "/all",
      event: setSubEvent
    });
  }, []);

  useEffect(() => {
    const updateFuns = {
      "init": (update) => {
        setChats(new Map(update["chats"]));
				if(update["conn"] === true) {
					setConn("available");
				} else
					setConn("dnd");
      }, "conn": (update) => {
				if(update == true) {
					setConn("available");
				} else
					setConn("dnd");
      }, "new": (update) => {
        let newChat = new Map(chats);
        newChat.set(update.name, {prompt: update.prompt, msgs: []});
        setChats(newChat)
      }, "del": (update) => {
        let newChat = new Map(chats);
        newChat.delete(update);
        setChats(newChat)
      }, "post": (update) => {
        if (chats.has(update.name)) {
          let newChat = new Map(chats);
          let chat = newChat.get(update.name);
          let msg = { when: update.when, who: update.who, what: update.what };
          newChat.set(update.name, {...chat, msgs: [...chat.msgs, msg]});
          setChats(newChat);
        }
      }
    };

    const eventTypes = Object.keys(subEvent);
    if (eventTypes.length > 0) {
      const eventType = eventTypes[0];
      updateFuns[eventType](subEvent[eventType]);
    };
  }, [subEvent]);

  useEffect(() => {
    if (currentChat === null) {
      setSidebarStyle({
        display: "flex",
        flexBasis: "auto",
        width: "100%",
        maxWidth: "100%"
      });
      setConversationContentStyle({
        display: "flex"
      });
      setChatContainerStyle({
        display: "none"
      });
    } else {
      setSidebarStyle({display: "none"});
      setConversationContentStyle({});
      setChatContainerStyle({});
    }
  }, [currentChat, setCurrentChat, setConversationContentStyle, setSidebarStyle, setChatContainerStyle]);
  
  return (
    <div className="h-screen v-screen">
      <PureModal
        isOpen={modal}
        closeButton={<FontAwesomeIcon icon={faXmark} />}
        closeButtonPosition="header"
        onClose={handleCloseModal}
        scrollable={false}
        draggable={true}
        width="360px"
      >
        <form onSubmit={handleCreate} className="flex flex-col gap-2 p-8">
          <input
            type="text"
            name="title"
            placeholder="Title"
            value={title}
            onChange={(e) => setTitle(e.target.value)}
          />
          <input
            type="text"
            name="title"
            placeholder="Prompt"
            value={prompt}
            onChange={(e) => setPrompt(e.target.value)}
          />
          <Button border>Create</Button>
        </form>
      </PureModal>
      <MainContainer className="max-w-4xl mx-auto">
			<Status status={conn} />
        <Sidebar position="left" scrollable={false} style={sidebarStyle}>
          <ConversationList>
            {
              Array.from(chats, (entry) =>
                <Conversation
                  key={entry[0]}
                  onClick={()=>handleConversationClick(entry[0])}
                >
                  <
                    Conversation.Content
                    name={entry[0]}
                    info={entry[1].prompt}
                    style={conversationContentStyle}
                  />
                  <Conversation.Operations visible>
                    <Button
                      icon={<FontAwesomeIcon icon={faXmark} />}
                      onClick={(e)=>handleDelete(e,entry[0])}
                    />
                  </Conversation.Operations>
                </Conversation>
              )
            }
          </ConversationList>
          <ConversationHeader>
            <ConversationHeader.Content className="flex flex-row">
              <Button
                className="w-full"
                icon={<FontAwesomeIcon icon={faPlus} />}
                onClick={handleAddClick}
              />
            </ConversationHeader.Content>
          </ConversationHeader>
        </Sidebar>

        <ChatContainer style={chatContainerStyle}>
          <ConversationHeader>
            <ConversationHeader.Back onClick={handleBackClick} />
            {
              (chats.has(currentChat)) &&
                <ConversationHeader.Content
                  userName={currentChat}
                  info={chats.get(currentChat).prompt}

                />
            }
          </ConversationHeader>
          <MessageList>
            {
              (chats.has(currentChat)) &&
                chats.get(currentChat).msgs.map(msg =>
                  <Message
                    key={msg.when}
                    model={{
                      message: msg.what,
                      sender: msg.who,
                      position: "single",
                      direction: (msg.who === "user") ? "outgoing" : "incoming"
                    }}
                  />
                )
            }
          </MessageList>
{
          (conn==="available" &&
					<MessageInput
            attachButton={false}
            placeholder="Type message here"
            value={message}
            onChange={(txt) => setMessage(txt)}
            onSend={() => handleSend()}
          /> )
}
        </ChatContainer>
      </MainContainer>
    </div>
  );
}
