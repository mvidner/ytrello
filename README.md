# YTrello

Tools to help with the YaST Trello boards.

- Make cards for bugs in Bugzilla.suse.com

### Requirements

- [bicho.gem][b] >= 0.0.10
- [ruby-trello.gem][t]
- [python-bugzilla][p], with the SUSE flavor

[b]: https://github.com/dmacvicar/bicho
[t]: https://github.com/jeremytregunna/ruby-trello
[p]: https://build.opensuse.org/package/show/openSUSE:Factory/python-bugzilla

### Setup

**ruby-trello** reads the environment variables
`TRELLO_DEVELOPER_PUBLIC_KEY` and `TRELLO_MEMBER_TOKEN`. I put them in
`~/.trellorc` and source it from my `~/.bashrc`

- The Developer Public Key is the first hex string on
  <https://trello.com/app-key>

```sh
F=~/.trellorc
touch $F
chmod 700 $F
echo "# https://github.com/mvidner/ytrello" >> $F
echo "export TRELLO_DEVELOPER_PUBLIC_KEY=replaceme" >> $F
vi $F
```

After you fill in the developer key, use this to request an app token, then
copy the generated token to the config file.

```sh
. $F
xdg-open "https://trello.com/1/authorize?key=$TRELLO_DEVELOPER_PUBLIC_KEY&name=ytrello&expiration=never&response_type=token&scope=read,write"
echo "export TRELLO_MEMBER_TOKEN=replaceme" >>$F
vi $F
```

**bicho** and **python-bugzilla** read ~/.oscrc so if you have used `osc` it
should work already.

## Usage

- **create**

```sh
create $BUG_NUMBER
```


- **addurl** is normally called by **create**,
  but in case you want to use it directly, it is straightforward. It will
  assign the **URL** field of a bug unless the field is already present.

```sh
addurl 999999 https://trello.example.com/cards/my-first-card
```
