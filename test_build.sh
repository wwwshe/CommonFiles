######################
# Param setup
######################
TARGET_NAME=sample
SCHEME=${TARGET_NAME}
CONFIGURATION=Debug
PROJECT_NAME=sample
SRCROOT=.
UNIT_TEST_TARGET=${PROJECT_NAME}Tests
UI_TEST_TARGET=${PROJECT_NAME}UITests



#xcodebuild test -scheme ${SCHEME} -project ${PROJECT_NAME}.xcodeproj -destination "platform=iOS Simulator,name=iPhone X,OS=13.2.2" | xcpretty --test --color

#Unit Test
#xcodebuild test -scheme ${SCHEME} -project ${PROJECT_NAME}.xcodeproj -configuration ${CONFIGURATION} -only-testing:sampleTests -destination "platform=iOS Simulator,name=iPhone X,OS=13.2.2" | xcpretty --test --color

#UI Test
xcodebuild test -scheme ${SCHEME} -project ${PROJECT_NAME}.xcodeproj -configuration ${CONFIGURATION} -only-testing:sampleUITests -destination "platform=iOS Simulator,name=iPhone X,OS=13.2.2" | xcpretty --test --color
