# YTrello Docker Configuration

Before starting using ytrello with docker we need to at least configure our OSC and ytrello credentiales as documented below.

### Copy your osc credentials as oscrc
```cp ~/.oscrc /ytrello_path/oscrc```

### Build ytrello
`docker build -t ytrello .`

### Add ytrello as an alias (recommended although not needed)

```bash
# Add to your .bashrc a ytrello alias and define the environment trello credentials
export TRELLO_DEVELOPER_PUBLIC_KEY=ffffffffffffffffffffffffffffffff
export TRELLO_MEMBER_TOKEN=ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
alias ytrello="docker run -ti -e TRELLO_DEVELOPER_PUBLIC_KEY=$TRELLO_DEVELOPER_PUBLIC_KEY -e TRELLO_MEMBER_TOKEN=$TRELLO_MEMBER_TOKEN ytrello"
```

### Start using it

```bash
ytrello ./check
ytrello ./create 1065...
```
