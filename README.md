# tokex.sh

Token exposure finder - A simple helper tool for auto-recon and crawl for hunting secret key through web files and web pages with crawling and OSINT methodology.

### Requirements
- `Golang`
- `gau` (golang tool)
- `katana` (golang tool)
- `nuclei` (golang tool)

## Installation

```
apt install golang-go -y
go install -v github.com/lc/gau/v2/cmd/gau@latest
go install github.com/projectdiscovery/katana/cmd/katana@latest
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
```

- Install tokex.sh

```
git clone https://github.com/xchopath/tokex.sh
```

## Setting

Adjust all binary files location in `tokex.sh`.

```
PROCESSPOOL=5
GAU_BIN="${HOME}/go/bin/gau"
KATANA_BIN="${HOME}/go/bin/katana"
NUCLEI_BIN="${HOME}/go/bin/nuclei"
```

## Usage

```
bash tokex.sh fqdn.domain
```

Example:

```
$ bash tokex.sh example.com

  _        _             
 | |_ ___ | | _______  __
 | __/ _ \| |/ / _ \ \/ /
 | || (_) |   <  __/>  < 
  \__\___/|_|\_\___/_/\_\
  Token Exposure Finder!

INFO: Target example.com
INFO: Checking HTTP connection...
INFO: Getting historical links example.com...
INFO: Crawling http://example.com/...
INFO: Finding secret key <####################################### > 99%
INFO: Finished!
INFO: Total findings: 0
INFO: Tesult file location tokex_results_1680248289.22646.txt
```
