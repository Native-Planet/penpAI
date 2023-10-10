|%
+$  who     ?(%system %user %assistant)
+$  msg     [=who what=@t]
+$  msgs    ((mop @da msg) gth)
+$  name    @t
+$  prompt  @t
+$  when    @da
::
+$  chat   [=prompt =msgs]
+$  chats  (map name chat)
::
+$  do
  $%  [%new =name =prompt]
      [%post =name msg]
      [%del =name]
  ==
+$  did
  $%  [%init chats=(list [=name =prompt msgs=(list [=when msg])])]
      [%new =name =prompt]
      [%post =name =when msg]
      [%del =name]
  ==
--
