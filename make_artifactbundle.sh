#!/bin/bash

set -e

echo "** make artifactbundle"

TEMPDIR="/tmp/mockolo.dst"
ARTIFACTBUNDLENAME="mockolo.artifactbundle"
ARTIFACTBUNDLEDIR="${TEMPDIR}/${ARTIFACTBUNDLENAME}"
EXECUTABLEPATH=".build/apple/Products/Release/mockolo"
VERSION=`cat Sources/MockoloFramework/Version.swift | awk -F '"' '{print $2}' | xargs`

rm -rf $ARTIFACTBUNDLEDIR
mkdir -p "${ARTIFACTBUNDLEDIR}/mockolo/bin"
sed "s/VERSION/${VERSION}/g" artifactbundle.info.json.template > "${ARTIFACTBUNDLEDIR}/info.json"
cp "${EXECUTABLEPATH}" "${ARTIFACTBUNDLEDIR}/mockolo/bin/"
cp "LICENSE.txt" "${ARTIFACTBUNDLEDIR}/"
(cd "${TEMPDIR}"; zip -yr - "${ARTIFACTBUNDLENAME}") > "./${ARTIFACTBUNDLENAME}.zip"

echo "checksum(${ARTIFACTBUNDLENAME}.zip): `swift package compute-checksum ${ARTIFACTBUNDLENAME}.zip`"
