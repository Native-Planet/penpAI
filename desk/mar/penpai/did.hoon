/-  *penpai
|_  d=did
++  grow
  |%
  ++  noun  d
  ++  json
    =,  enjs:format
    |^  ^-  ^json
    ?-  -.d
      %post  (frond %post (pairs chat+s+chat.d msg+(msg msg.d) ~))
      %del   (frond %del s+chat.d)
      %init  (frond %init a+(turn ~(tap by chats.d) chat))
    ==
    ::
    ++  chat
      |=  [=^chat =msgs]
      ^-  ^json
      (pairs chat+s+chat msgs+a+(turn msgs msg) ~)
    ::
    ++  msg
      |=  =^msg
      ^-  ^json
      (pairs who+s+who.msg what+s+what.msg ~)
    --
  --
++  grab
  |%
  ++  noun  did
  --
++  grad  %noun
--
