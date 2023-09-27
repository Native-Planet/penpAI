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
  |^  ^-  (quip card _this)
  ?>  ?=(%penpai-do mark)
  ?.  =(our.bol src.bol)  !!
    (local !<(penpai-act vase))
  ++  local
    |=  act=penpai-act
    ^-  (quip card _this)
    ?-    -.act
        %post
        ~&  >  'post'  !!
      ::=/  =path
        ::/(scot %p host.gid.hut.act)/[name.gid.hut.act]
      ::?.  =(our.bol host.gid.hut.act)
        :::_  this
        :::~  (~(poke pass:io path) [host.gid.hut.act %hut] [mark vase])
        ::==
      ::=/  =msgs  (~(get ja msg-jar) hut.act)
      ::=.  msgs
        ::?.  (lte 50 (lent msgs))
          ::[msg.act msgs]
        ::[msg.act (snip msgs)]
      :::_  this(msg-jar (~(put by msg-jar) hut.act msgs))
      :::~  (fact:io hut-did+vase path /all ~)
      ::==
    ::
        %new
        ~&  >  ['new' act]  
      =/  =path
        /(scot %p id.chat.act)/[name.chat.act]
      :-  :~  (fact:io penpai-did+vase path /all ~)
          ==
      this(chats (~(add ja chats) chat.act msgs.act))
    ::
        %del
        ~&  >  'del'  !!
      ::?>  =(our.bol host.gid.hut.act)
      ::=/  =path
        ::/(scot %p host.gid.hut.act)/[name.gid.hut.act]
      :::-  :~  (fact:io hut-did+vase path /all ~)
          ::==
      ::%=  this
        ::huts     (~(del ju huts) gid.hut.act name.hut.act)
        ::msg-jar  (~(del by msg-jar) hut.act)
      ::==
    ==
  --
::
++  on-agent  on-agent:def
::
++  on-watch  ::on-watch:def
  |=  =path
  ^-  (quip card _this)
  ?:  ?=([%all ~] path)
    ?>  =(our.bol src.bol)
    :_  this
    :~  %-  fact-init:io
        penpai-did+!>(`penpai-upd`[%init-all chats])
    ==
  `this
::
++  on-leave  on-leave:def
::
++  on-peek  
  |=  =path
  ^-  (unit (unit cage))
  ?+    path  (on-peek:def path)
  ::
      [%x %titles ~]
    :^  ~  ~  %json
    !>  ^-  json
    :-  %a
    %+  turn
      ~(tap in ~(key by chats))
    |=  [id=@ name=@tas]
    ^-  json
    %-  pairs:enjs:format
    :~  :-  'chat'
        %-  pairs:enjs:format
        :~  ['id' s+id]
            ['name' s+name]
        ==
    ==
  ==
++  on-arvo
  |=  [=wire sign=sign-arvo]
  ^-  (quip card _this)
  ?.  ?=([%lick %soak *] sign)  (on-arvo:def +<)
  ?+    [mark noun]:sign        (on-arvo:def +<)
    [%connect ~]     ((slog 'socket connected' ~) `this)
    [%disconnect ~]  ((slog 'socket disconnected' ~) `this)
    [%error *]       ((slog leaf+"socket {(trip ;;(@t noun.sign))}" ~) `this)
    [%chat *]        ((slog 'chat!' ~) `this)
  ==
++  on-fail  on-fail:def
--

