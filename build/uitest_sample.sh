#!/bin/bash

WORKSPACE="DDota.xcworkspace"
SCHEME="DDota"
TARGET="DDota"

xcodebuild -workspace ${WORKSPACE} -scheme ${SCHEME} -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 11 Pro Max,OS=latest' test | xcpretty --report html

echo 'wjswjddnr1' | sudo -S chmod 777 build/reports/tests.html

open build/reports/tests.html
