1. $ sduo pacman -S ibus ibus-table ibus-table-chinese
2. $ sudo echo >> /etc/profile
   $ sudo echo export GTK_IM_MODULE=ibus >> /etc/profile
   $ sudo echo export XMODIFIERS=@im=ibus >> /etc/profile
   $ sudo echo export QT_IM_MODULE=ibus >> /etc/profile
   1. $ ibus-setup
      Inital status:
      ​    Input mode:                     direct: no input; table: input
      ​    Chinese mode:                   simple & taiwan
      ​    Table input letter width:       width when input: half full
      ​    Table input punctuation width:  width when input: half full
      ​    Direct input letter width:      width when no input: half full
      ​    Direct input punctuation width: width when no input: half full
      condidate list:
      ​    Show condidate list:
      ​    Orientation:                     panel orientation
      ​    Page size:	                     max number of chars in panel 
      Details:
      ​    Compose:                         single char; words
      ​    Auto select:                  
      ​    Autocommit mode:
      ​    Behavior of space key:            commit; next page
      ​    Auto wildcard:
      ​    Single wildcard character:
      ​    Multi wildcard character:
3. $ setsid ibus-daemon &