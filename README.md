# tokex.sh

Token exposure finder - A simple helper tool for auto-recon and crawl for hunting secret key through web files and web pages.

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
bash tokex.sh www.example.com
```
