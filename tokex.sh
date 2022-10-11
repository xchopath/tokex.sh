#!/usr/bin/env bash
# tokex.sh
# Made by @xchopath

NUCLEI_BIN="${HOME}/go/bin/nuclei"
GAU_BIN="${HOME}/go/bin/gau"

TARGET_FQDN="${1}"
FILE_TEMP="/tmp/tokexurls.$(date +%s).${RANDOM}.tmp"

BANNER='''
  _        _             
 | |_ ___ | | _______  __
 | __/ _ \| |/ / _ \ \/ /
 | || (_) |   <  __/>  < 
  \__\___/|_|\_\___/_/\_\
  Token Exposure Scanner
'''
echo "${BANNER}"

if [[ -z ${TARGET_FQDN} ]]; then
	echo " Usage:"
	echo "   $ tokex.sh www.example.com"
fi

echo "[INFO] Target: ${TARGET_FQDN}"

if [[ -f ${FILE_TEMP} ]]; then
	rm ${FILE_TEMP}
	touch ${FILE_TEMP}
fi

TARGET_HTTP="$(curl -Ls -o /dev/null -w %{url_effective} ${TARGET_FQDN})"
echo "${TARGET_HTTP}" >> ${FILE_TEMP}

# Run GAU
echo "${TARGET_FQDN}" | ${GAU_BIN} | sort -V | uniq >> ${FILE_TEMP}

# Run Nuclei
for URL in $(cat ${FILE_TEMP})
do
	${NUCLEI_BIN} -t exposures/tokens/ -u "${URL}" -silent
done

if [[ -f ${FILE_TEMP} ]]; then
	rm ${FILE_TEMP}
fi

echo "[INFO] DONE!"
