/-  *penpai
|_  d=did
++  grow
  |%
  ++  noun  d
  ++  json
    =,  enjs:format
    |^  ^-  ^json
    ?-  -.d
      %new   (frond %new (pairs name+s+name.d prompt+s+prompt.d ~))
      %del   (frond %del s+name.d)
      %init  (frond %init (pairs chats+a+(turn chats.d chat) conn+b+connected.d ~))
      %post  %+  frond  %post
             %-  pairs
             :~  name+s+name.d
                 when+(time when.d)
                 who+s+who.d
                 what+s+what.d
             ==       
      %conn  (frond %conn b+connected.d)
    ==
    ::
    ++  chat
      |=  [=name =prompt msgs=(list [=when msg])]
      ^-  ^json
      :-  %a
      :~  s+name
          (pairs prompt+s+prompt msgs+a+(turn msgs msg-item) ~)
      ==
    ::
    ++  msg-item
      |=  [=when msg]
      ^-  ^json
      (pairs when+(time when) who+s+who what+s+what ~)
    --
  --
++  grab
  |%
  ++  noun  did
  --
++  grad  %noun
--
