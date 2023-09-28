|%
+$  who      $?(%system %user %assistant)
+$  msg      [=who what=@t]
+$  msgs     (list msg)
+$  name     @tas
+$  chat     [id=@t =name]
::
+$  chats  (jar chat msg)
::
+$  penpai-act
  $%  [%new =chat =msgs]
      [%post =chat =msg]
      [%del =chat]
  ==
+$  penpai-upd
  $%  [%init =chats]
      [%init-all =chats]
      penpai-act
  ==
--
