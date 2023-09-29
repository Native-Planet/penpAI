/-  *penpai
/+  default-agent, dbug, agentio
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0  [%0 =chats]
+$  card  card:agent:gall
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
      %post
    =.  chats  (~(add ja chats) chat.do msg.do)
    :_  this
    :~  (fact:io penpai-did+vase /all ~)
        %-  ~(arvo pass:io /spit)
        [%l %spit /'chat.sock' %chat (~(get ja chats) chat.do)]
    == 
  ::
      %del
    :_  this(chats (~(del by chats) chat.do))
    :~  (fact:io penpai-did+vase /all ~)
    ==
  ==
::
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?>  =(our.bol src.bol)
  ?>  ?=([%all ~] path)
  :_  this
  :~  (fact-init:io penpai-did+!>(`did`[%init chats]))
  ==
::
++  on-arvo
  |=  [=wire sign=sign-arvo]
  ^-  (quip card _this)
  ?.  ?=([%lick %soak *] sign)  (on-arvo:def +<)
  ?+    mark.sign  (on-arvo:def +<)
      %connect     ((slog 'socket connected' ~) `this)
      %disconnect  ((slog 'socket disconnected' ~) `this)
      %error       ((slog leaf+"socket {(trip ;;(@t noun.sign))}" ~) `this)
      %chat  
    =+  ;;([=chat =msg] noun.sign)
    :_  this(chats (~(add ja chats) chat msg))
    :~  (fact:io penpai-did+!>(`did`[%post chat msg]) /all ~)
    ==
  ==
::
++  on-agent  on-agent:def
++  on-peek   on-peek:def
++  on-leave  on-leave:def
++  on-fail   on-fail:def
--

