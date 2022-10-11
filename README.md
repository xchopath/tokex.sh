# tokex.sh

Tokex is a simple bug-bounty tool for auto recon and hunting Secret Key in Web Files.

## Installation

1. Install gau
```
go install -v github.com/lc/gau/v2/cmd/gau@latest
```

2. Install nuclei
```
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
```

3. Install tokex.sh
```
git clone https://github.com/xchopath/tokex.sh
```

4. Move to /usr/bin/
```
cd tokex.sh
ln -sf $(pwd)/tokex.sh /usr/bin/tokex.sh
```

## Setting

Nuclei and gau binary in `tokex.sh`
```
NUCLEI_BIN="${HOME}/go/bin/nuclei"
GAU_BIN="${HOME}/go/bin/gau"
```

## Usage
```
tokex.sh www.example.com
```
