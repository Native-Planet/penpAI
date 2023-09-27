import React, {useState, useEffect} from "react";
import ConnStatus from "./components/ConnStatus";
import SelectChat from "./components/SelectChat";
import Chats from "./components/Chats";
import ChatInput from "./components/ChatInput";
import People from "./components/People";
import Messages from "./components/Messages";
import { appPoke, idToStr, hutToStr } from "~/lib";
import { OUR } from "~/const";
import api from "~/api";
import "~/app.css";

export default function App() {
  const [subEvent, setSubEvent] = useState({});   // object
  const [conn, setConn] = useState(null);         // string?

  // gid: ~host/squad-name
  // hut: hut-name
  const [squads, setSquads] = useState(new Map());             // gid => title
  const [chats, setChats] = useState(new Map());                 // gid => {hut, ...}
  const [chatContents, setChatContents] = useState(new Map()); // hut => [string, ...]
  const [chatMembers, setChatMembers] = useState(new Map());   // gid => {~member, ...}

  const [chatInput, setChatInput] = useState("");      // string
  const [hutInput, setHutInput] = useState("");        // string
  const [viewSelect, setViewSelect] = useState("def"); // string (option)
  const [currGid, setCurrGid] = useState(null);        // gid?
  const [currChat, setCurrChat] = useState(null);        // hut?

  useEffect(() => {
    api.onOpen = () => setConn("ok");
    api.onRetry = () => setConn("try");
    api.onError = () => setConn("err");

    const subscription = api.subscribe({
      app: "penpai",
      path: "/all",
      event: setSubEvent,
    });
    return () => {
      api.unsubscribe(subscription);
    };
  }, [api]);

  useEffect(() => {
    api.scry({
      app: "penpai",
      path: "/titles",
    }).then((titles) => {
      console.log("titles", titles)
      let newChats = new Map();
      titles.forEach(obj => {
        const chatStr = idToStr(obj.chat);
        if (!newChats.has(chatStr)) {
          newChats.set(chatStr, obj.chat);
        }
      });

      setChats(newChats);
    });
  }, []);

  useEffect(() => {
    const updateFuns = {
      "initAll": (update) => {
        if (update.chats !== null) {
          console.log("initall", update)
          update.chats.forEach(obj =>
            chats.set(obj.id, new Set(obj.msgs))
          );
        }
      }, "init": (update) => {
        setChatContents(new Map(update.msgJar.reduce(
          (a, n) => a.set(hutToStr(n.hut), n.msgs)
        , chatContents)));
        setChats(new Map(huts.set(
          gidToStr(update.huts[0].gid),
          new Set(update.huts[0].names)
        )));
        setChatMembers(new Map(chatMembers.set(
          gidToStr(update.joined[0].gid),
          new Set(update.joined[0].ppl)
        )));
      }, "new": (update) => {
        console.log(update)
        const gidStr = gidToStr(update.hut.gid);
        const hutStr = hutToStr(update.hut);
        if (huts.has(gidStr)) {
          huts.get(gidStr).add(update.hut.name);
        } else {
          huts.set(gidStr, new Set(update.hut.name));
        }

        setChats(new Map(huts));
        setChatMembers(new Map(chatMembers.set(hutStr, update.msgs)));
      }, "post": (update) => {
        const newHut = hutToStr(update.hut);
        if (chatContents.has(newHut)) {
          chatContents.set(newHut, [...chatContents.get(newHut), update.msg]);
        } else {
          chatContents.set(newHut, [update.msg]);
        }

        setChatContents(new Map(chatContents));
      }, "del": (update) => {
        const gidStr = gidToStr(update.hut.gid);
        const hutStr = hutToStr(update.hut);
        if (huts.has(gidStr)) {
          huts.get(gidStr).delete(update.hut.name);
        }
        chatContents.delete(hutStr);

        setChats(new Map(huts));
        setChatContents(new Map(chatContents));
        setCurrChat((currChat === hutStr) ? null : currChat);
      },
    };

    const eventTypes = Object.keys(subEvent);
    if (eventTypes.length > 0) {
      const eventType = eventTypes[0];
      console.log(eventType);
      updateFuns[eventType](subEvent[eventType]);
    }
  }, [subEvent]);

  console.log("chatcontent",chatContents)
  console.log("curchat",currChat)
  console.log("viewSelect", viewSelect)
  return (
    <React.Fragment>
      <ConnStatus conn={conn}/>
      <SelectChat
        chats={chats}
        viewSelect={viewSelect}
        setView={setViewSelect}
      />
      <main>
        <div className="content">
          <Messages
            content={(!chats.has(currChat))
              ? []
              : chats.get(currChat)
            }
          />
          <ChatInput
            input={chatInput}
            setInput={setChatInput}
            currChat={currChat} />
        </div>
      </main>
    </React.Fragment>
  );
}
