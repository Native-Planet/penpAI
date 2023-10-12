/-  *penpai, hark
/+  default-agent, dbug, agentio
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0  [%0 =chats connected=?]
+$  card  card:agent:gall
++  orm  ((on @da msg) gth)
--
::
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
|_  bol=bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bol)
    io    ~(. agentio bol)
    hc    ~(. +> bol)
++  on-init
  ^-  (quip card _this)
  :_  this
  :~  [%pass / %arvo %l %spin /'chat.sock']
  ==
++  on-save  !>(state)
++  on-load
  |=  old-vase=vase
  ^-  (quip card _this)
  [~ this(state !<(state-0 old-vase))]
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?>  ?=(%penpai-do mark)
  ?>  =(our.bol src.bol)
  =+  !<(=do vase)
  ?-    -.do
      %new
    ?<  (~(has by chats) name.do)
    =.  chats  (~(put by chats) name.do prompt.do ~)
    :_  this
    :~  (fact:io penpai-did+vase /all ~)
    ==
  ::
      %post
    =/  =chat  (~(got by chats) name.do)
    ?.  connected  ~&  >>>  "lick socket not connected"  !!
    =/  =time  (from-unix-ms:chrono:userlib (unm:chrono:userlib now.bol))
    =.  msgs.chat  (put:orm msgs.chat time who.do what.do)
    =.  chats  (~(put by chats) name.do chat)
    =/  note=note-arvo
      :^  %l  %spit  /'chat.sock'
      ^-  [^mark name (list msg)]
      :^  %chat  name.do  [%system prompt.chat]
      (flop (turn (tap:orm msgs.chat) |=([=when =msg] msg)))
    :_  this
    :~  (fact:io penpai-did+!>(`did`[%post name.do time who.do what.do]) /all ~)
        (~(arvo pass:io /spit) note)
    == 
  ::
      %del
    :_  this(chats (~(del by chats) name.do))
    :~  (fact:io penpai-did+vase /all ~)
    ==
  ==
::
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?>  =(our.bol src.bol)
  ?>  ?=([%all ~] path)
  =/  initial
    %+  turn  ~(tap by chats)
    |=  [=name =prompt =msgs]
    ^-  [=^name =^prompt msgs=(list [=when msg])]
    [name prompt (flop (tap:orm msgs))]
  :_  this
  :~  (fact-init:io penpai-did+!>(`did`[%init initial]))
  ==
::
++  on-arvo
  |=  [=wire sign=sign-arvo]
  ^-  (quip card _this)
  ?.  ?=([%lick %soak *] sign)  (on-arvo:def +<)
  ?+    mark.sign  (on-arvo:def +<)
      %connect     
    ~&  'socket connected'
    :-  ~
    this(connected %.y)
      %disconnect
    ~&  'socket disconnected'
    :-  ~
    this(connected %.n)
      %error       ((slog leaf+"socket {(trip ;;(@t noun.sign))}" ~) `this)
      %chat  
    =+  ;;([=name =msg] noun.sign)
    ?~  chat=(~(get by chats) name)
      `this
    =/  hark-cards=(list card)
      ?.  .^(? %gu /(scot %p our.bol)/hark/(scot %da now.bol)/$)
        ~
      =/  con=(list content:hark)  [(crip "New penpAI message in {(trip name)}") ~]
      =/  =id:hark      (end 7 (shas %penpai-notification eny.bol))
      =/  =rope:hark    [~ ~ q.byk.bol /(scot %p our.bol)/[dap.bol]]
      =/  =action:hark  [%add-yarn & & id rope now.bol con /[dap.bol] ~]
      =/  =cage         [%hark-action !>(action)]
      [%pass /hark %agent [our.bol %hark] %poke cage]~
    =/  =time  (from-unix-ms:chrono:userlib (unm:chrono:userlib now.bol))
    =.  msgs.u.chat  (put:orm msgs.u.chat time msg)
    :_  this(chats (~(put by chats) name u.chat))
    %+  weld  hark-cards
    :~  (fact:io penpai-did+!>(`did`[%post name time msg]) /all ~)
    ==
  ==
::
++  on-peek   on-peek:def
++  on-agent  on-agent:def
++  on-leave  on-leave:def
++  on-fail   on-fail:def
--

