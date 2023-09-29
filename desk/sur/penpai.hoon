|%
+$  who      ?(%system %user %assistant)
+$  msg      [=who what=@t]
+$  msgs     (list msg)
+$  chat     @t
::
+$  chats  (jar chat msg)
::
+$  do
  $%  [%post =chat =msg]
      [%del =chat]
  ==
+$  did
  $%  [%init =chats]
      do
  ==
--
