#!/usr/bin/env bash
# tokex.sh
# Usage: bash tokex.sh targetfqdn.com
# Made by @xchopath

PROCESSPOOL=5
GAU_BIN="${HOME}/go/bin/gau"
KATANA_BIN="${HOME}/go/bin/katana"
NUCLEI_BIN="${HOME}/go/bin/nuclei"

function _loadingbar {
   let _progress=(${1}*100/${2}*100)/100
   let _done=(${_progress}*4)/10
   let _left=40-$_done
   _fill=$(printf "%${_done}s")
   _empty=$(printf "%${_left}s")
   printf "\rINFO: Finding secret key <${_fill// /\#}${_empty// / }> ${_progress}%%"
}

TARGET_FQDN="${1}"

FILE_TEMP="/tmp/tokexurls.$(date +%s).${RANDOM}.tmp"
RESULT_FILE="tokex_results_$(date +%s).${RANDOM}.txt"
touch ${RESULT_FILE}

BANNER='''
  _        _             
 | |_ ___ | | _______  __
 | __/ _ \| |/ / _ \ \/ /
 | || (_) |   <  __/>  < 
  \__\___/|_|\_\___/_/\_\
  Token Exposure Finder!
'''
echo "${BANNER}"

if [[ -z ${TARGET_FQDN} ]]; then
	echo "[ERROR] There is no target provided"
	echo " Usage:"
	echo "   $ tokex.sh www.example.com"
	exit
fi

echo "INFO: Target ${TARGET_FQDN}"

if [[ -f ${FILE_TEMP} ]]; then
	rm ${FILE_TEMP}
	touch ${FILE_TEMP}
fi

echo "INFO: Checking HTTP connection..."
TARGET_HTTP="$(curl -Ls -o /dev/null -w %{url_effective} ${TARGET_FQDN})"
echo "${TARGET_HTTP}" >> ${FILE_TEMP}

# Run gau
echo "INFO: Getting historical links ${TARGET_FQDN}..."
echo "${TARGET_FQDN}" | ${GAU_BIN} >> ${FILE_TEMP}

# Run katana
echo "INFO: Crawling ${TARGET_HTTP}..."
echo ${TARGET_HTTP} | ${KATANA_BIN} -silent >> ${FILE_TEMP}

# Run nuclei
link_count=0
total_links=$(cat ${FILE_TEMP} | sort -V | uniq | wc -l)
(
	for URL in $(cat ${FILE_TEMP} | sort -V | uniq)
	do
		((PROCNUM=PROCNUM%PROCESSPOOL)); ((PROCNUM++==0)) && wait
		_loadingbar "${link_count}" "${total_links}"
		${NUCLEI_BIN} -t exposures/tokens/ -u "${URL}" -silent >> ${RESULT_FILE} &
		((link_count++))
	done
	wait
)

if [[ -f ${FILE_TEMP} ]]; then
	rm ${FILE_TEMP}
fi

echo ""
echo "INFO: Total findings $(cat ${RESULT_FILE} | wc -l)"
echo "INFO: Tesult file location ${RESULT_FILE}"

echo "INFO: Done!"
