export LANG=en_US.UTF-8

# config
APP_NAME=$1
GROUP_ALIASES=$2
PROJECT_NAME=$(echo $APP_NAME | awk -F. '{print $1}')
APP_BUILD_NUMBER=$(date +"%y%m%d%H%M")
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion ${APP_BUILD_NUMBER}" ./${PROJECT_NAME}/Info.plist

# Script Options File
SCRIPT_OPTIONS_FILE=`pwd`/buildscriptOptions.plist
cat << EOF > ${SCRIPT_OPTIONS_FILE}
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>app-store</string>
    <key>teamID</key>
    <string>0000000000</string>
    <key>uploadBitcode</key>
    <true/>
    <key>compileBitcode</key>
    <true/>
    <key>uploadSymbols</key>
    <true/>
    <key>signingStyle</key>
    <string>manual</string>
    <key>signingCertificate</key>
    <string>iPhone Distribution</string>
    <key>provisioningProfiles</key>
    <dict>
        <key>kr.co.magicmon.test.app</key>
        <string>[app_distribution]</string>
    </dict>
</dict>
</plist>
EOF

# Install Pod
/usr/local/bin/pod install

# Create IPA Folder
ARCHIVEPATH=`pwd`/archive
mkdir -p ${ARCHIVEPATH}

# Build & Export as IPA
xcodebuild clean -workspace ${PROJECT_NAME}.xcworkspace -configuration Release -scheme ${PROJECT_NAME}
xcodebuild archive -workspace ${PROJECT_NAME}.xcworkspace -configuration Release -scheme ${PROJECT_NAME} -archivePath ${ARCHIVEPATH}/${PROJECT_NAME}.xcarchive
xcodebuild -exportArchive -archivePath ${ARCHIVEPATH}/${PROJECT_NAME}.xcarchive -exportPath ${ARCHIVEPATH} -exportOptionsPlist ${SCRIPT_OPTIONS_FILE}

# rename to ipa file
if [ -r ${ARCHIVEPATH}/${PROJECT_NAME}.ipa ]
then

# Upload IPA & Notify by Email
`pwd`/Pods/Crashlytics/submit xxxxxx xxxxxx \
-ipaPath ${ARCHIVEPATH}/${PROJECT_NAME}.ipa \
-groupAliases ${GROUP_ALIASES} \
-notifications YES

# remove temp files
rm -rf ${ARCHIVEPATH}
rm -f ${SCRIPT_OPTIONS_FILE}

else
# remove temp files
rm -rf ${ARCHIVEPATH}
rm -f ${SCRIPT_OPTIONS_FILE}

exit 1
fi
