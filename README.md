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

### Installation

From a Git checkout:

```sh
sudo zypper install python-bugzilla
bundle install
alias ytrello="bundle exec ytrello"
```

From Rubygems:

```sh
sudo zypper install python-bugzilla
gem install ytrello
```

From OBS, this selects the appropriate Ruby version:

```sh
zypper install -C 'rubygem(ytrello)'
```

### Setup

**ruby-trello** reads the configuration file `~/.config/trello-creds.yml`:

- The Developer Public Key is the first hex string on
  <https://trello.com/app-key>

```sh
F=~/.config/trello-creds.yml`
touch $F
chmod 700 $F
echo "# https://github.com/mvidner/ytrello" >> $F
echo "TRELLO_DEVELOPER_PUBLIC_KEY: replaceme" >> $F
vi $F
```

After you fill in the developer key, use this to request an app token, then
copy the generated token to the config file.

```sh
xdg-open "https://trello.com/1/authorize?key=REPLACEME&name=ytrello&expiration=never&response_type=token&scope=read,write"
echo "TRELLO_MEMBER_TOKEN: replaceme" >>$F
vi $F
```

For backward compatibility, the environment variables
`TRELLO_DEVELOPER_PUBLIC_KEY` and `TRELLO_MEMBER_TOKEN` are respected, and
even preferred over the configuration file.

**bicho** and **python-bugzilla** read ~/.oscrc so if you have used `osc` it
should work already.

## Usage

- **create**

```sh
ytrello create $BUG_NUMBER
```


- **addurl** is normally called by **create**,
  but in case you want to use it directly, it is straightforward. It will
  assign the **URL** field of a bug unless the field is already present.

```sh
ytrello addurl 999999 https://trello.example.com/cards/my-first-card
```

- **check** runs some validation checks and reports the found issues:

  - It checks whether the YaST team bugs have a link to a Trello card (in the
    **URL** field).
  - It checks that all open YaST team bugs are tracked in Trello (i.e. a card
    exists).
  - Reports the Trello cards which refer to a closed bug in bugzilla. These
    cards should be moved to *Done* or archived if the bug is not valid anymore.

  The command supports a simple auto correction mode. In this mode it tries
  to fix the found issues. Use `-a` or `--auto-correct` option to turn it on
  (by default it is disabled).

  Currently these auto correct actions are performed:

  - The missing links from Bugzilla bugs to the Trello cards are added.
  - Missing Trello cards are created

  It is recommended to run it in read-only mode first to see the found issues:

  ```sh
  ytrello check
  ```

  If the reported changes are valid you can fix them by running:

  ```sh
  ytrello check -a
  ```
