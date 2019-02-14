#!/bin/bash
set -e

if [[ -n "${SWIFT_LANGUAGE_VERSION}" ]]
then
  VERSION_OPTION="-Xswiftc -swift-version -Xswiftc ${SWIFT_LANGUAGE_VERSION}"
fi

if [[ $SWIFT_LANGUAGE_VERSION = "3" ]] || [[ $SWIFT_MAJOR_VERSION = "3" ]]
then
  RELEASE=""
else
  RELEASE="-c release"
fi

swift --version
swift test ${RELEASE} ${VERSION_OPTION}
