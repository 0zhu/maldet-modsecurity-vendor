#!/bin/bash
# https://github.com/zhubanRuban/malware-expert-rbl-modsecurity-vendor

# destination repo settings
DESTBASENAME=maldet-modsecurity-vendor
DESTREPO=https://github.com/zhubanRuban/${DESTBASENAME}
DESTBRANCH=master

# modsecurity vendor properties
VENDESC="Modsecurity Vendor created from https://www.rfxn.com/appdocs/README.maldetect"
VENDNAME="Maldet"
VENDURL="${DESTREPO}"

DISTR=$(date +%Y%m%d)
DESTDIR=maldet
ARCHIVE=${DESTDIR}.zip
rm -f ${ARCHIVE}
zip -r ${ARCHIVE} ${DESTDIR}
MD5SUM=$(md5sum ${ARCHIVE}|awk '{print $1}')
SHA512SUM=$(sha512sum ${ARCHIVE}|awk '{print $1}')

YAMLFILE=meta_${DESTDIR}.yaml
# example: http://httpupdate.cpanel.net/modsecurity-rules/meta_OWASP3.yaml
(
	echo "--- "
	for MODSECVER in 2.9.0 2.9.2; do
		echo "${MODSECVER}: "
		echo "  MD5: ${MD5SUM}"
		echo "  SHA512: ${SHA512SUM}"
		echo "  distribution: ${DISTR}"
		echo "  url: ${DESTREPO}/raw/${DESTBRANCH}/${ARCHIVE}"
	done
	for MODSECVER in 2.9.3 2.9.4 2.9.5 2.9.6 2.9.7 3.0.0 3.0.1 3.0.2 3.0.3 3.0.4; do
		echo "${MODSECVER}: "
		echo "  MD5: ${MD5SUM}"
		echo "  SHA512: ${SHA512SUM}"
		echo "  defaulted: 1"
		echo "  distribution: ${DISTR}"
		echo "  url: ${DESTREPO}/raw/${DESTBRANCH}/${ARCHIVE}"
	done
	echo "attributes: "
	echo "  description: ${VENDESC}"
	echo "  name: ${VENDNAME}"
	echo "  vendor_url: ${VENDURL}"
) > ${YAMLFILE}
echo -e "Archive:\t${ARCHIVE}\nYAML:\t\t${YAMLFILE}"
