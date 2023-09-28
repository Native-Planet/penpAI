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
        ::~&  >  'post' 
      =/  =path
        /[id.chat.act]/[name.chat.act]
      :_  this(chats (~(add ja chats) chat.act msg.act))
      :~  (fact:io penpai-did+vase path /all ~)
        [%pass / %arvo %l %spit /'chat.sock' %chat [chat.act (flop `(list)`(~(get by chats) chat.act))]] 
      == 
    ::
        %new
        ::~&  >  ['new' act]  
      =/  =path
        /[id.chat.act]/[name.chat.act]
        ~&  msgs.act
      :-  :~  (fact:io penpai-did+vase path /all ~)
          ==
      this(chats (~(add ja chats) chat.act &1.msgs.act))
    ::
        %del
        ::~&  >  'del' 
      =/  =path
        /[id.chat.act]/[name.chat.act]
      :-  :~  (fact:io penpai-did+vase path /all ~)
          ==
      %=  this
        chats  (~(del by chats) chat.act)
      ==
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
    [%chat *]  
      =/  data=[chat=[@t @t] msg=[who @t]]  ;;([[@t @t] [who @t]] noun.sign)
      =/  =path
        /[-.chat.data]/[+.chat.data]
        ~&  >>>  path
      :_  this(chats (~(add ja chats) -.data +.data))
      :~  (fact:io penpai-did+!>(data) path ~[/all])
      ==
  ==
++  on-fail  on-fail:def
--

