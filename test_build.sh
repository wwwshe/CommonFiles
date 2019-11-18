######################
# Param setup
######################
TARGET_NAME=sample
SCHEME=${TARGET_NAME}
CONFIGURATION=Debug
PROJECT_NAME=sample
SRCROOT=.




xcodebuild test -scheme ${SCHEME} -project ${PROJECT_NAME}.xcodeproj -destination "platform=iOS Simulator,name=iPhone X,OS=13.2.2"
