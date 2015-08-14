# Useful SSH commands
## ssh-agent
If not started yet:
```
eval $(ssh-agent)
```
(should not be necessary under i3)

## ssh-add
* Add private key: ```ssh-add```
* List keys: ```ssh-add -l```
* Remove all keys: ```ssh-add -D```

## ssh-copy-id
```
ssh-copy-id <server>
```
