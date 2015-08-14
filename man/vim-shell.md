# Calling shell commands from vim
* Execute a command: ```:!<command>```
* Parameter ```%``` is the name of the current file (make sure to save first)
* Pipe current buffer to a command: ```:w !<command>```
  * Works with ranges as well: ```:1,10w !<command>```

See also: [StackOverflow](http://stackoverflow.com/questions/7867356/piping-buffer-to-external-command-in-vim)
