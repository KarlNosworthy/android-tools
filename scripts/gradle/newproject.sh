#!/bin/bash
#
# Feel free to take, distribute, copy, install, rename, modify or
# enhance this script. I hope it comes in handy. If you have ideas
# to make it better...you know where it came from.
#
# newproject							   		created: 3/06/2013
# ================================================================
#
# A simple utility to create a new gradle based android project with
# the correct directory structure and default AndroidManifest, strings.xml
# and gradle.build files.
#
# newproject.sh <project name> <path> <root package name> [compile sdk version] [main activity name]

if [ "$#" -lt "3" ]
	then
	echo "newproject.sh <project name> <path> <root package name> [compile sdk version] [main activity name]"
	exit
fi

# Store parameter values
PROJECT_NAME="$1"
PROJECT_PATH="$2"
PROJECT_PACKAGE_NAME="$3"

# check if a target/build sdk version has been passed in
if [ -n "$4" ]
	then
	PROJECT_COMPILE_SDK_VERSION="17"
else
	PROJECT_COMPILE_SDK_VERSION="$4"
fi

# check if a main activity name has been specified
if [ -n "$5" ]
	then
	PROJECT_MAIN_ACTIVITY_NAME="$5"
fi

# Set target root project path
TARGET_PROJECT_PATH=${PROJECT_PATH}/${PROJECT_NAME}

# Create project directories at specified path
mkdir -p ${TARGET_PROJECT_PATH}/src/main/java
mkdir -p ${TARGET_PROJECT_PATH}/src/main/res

# Create a default manifest file
echo "<?xml version=\"1.0\" encoding=\"utf-8\"?>" >> ${TARGET_PROJECT_PATH}/src/main/AndroidManifest.xml
echo "<manifest xmlns:android=\"http://schemas.android.com/apk/res/android\"" >> ${TARGET_PROJECT_PATH}/src/main/AndroidManifest.xml
echo -e "\tpackage=\"${PROJECT_PACKAGE_NAME}\"\n\tandroid:versionCode=\"1\"\n\tandroid:versionName=\"1.0\" >" >> ${TARGET_PROJECT_PATH}/src/main/AndroidManifest.xml
if [ -n "$PROJECT_MAIN_ACTIVITY_NAME" ] 
	then
		echo "<application android:allowBackup=\"true\" android:icon=\"@drawable/ic_launcher\" android:label=\"@string/app_name\">" >> ${TARGET_PROJECT_PATH}/src/main/AndroidManifest.xml
		echo -e "\t<activity android:name=\".${PROJECT_MAIN_ACTIVITY_NAME}\" android:label=\"@string/app_name\"" >> ${TARGET_PROJECT_PATH}/src/main/AndroidManifest.xml
		echo -e "\t\t<intent-filter>" >> ${TARGET_PROJECT_PATH}/src/main/AndroidManifest.xml
		echo -e "\t\t\t<action android:name=\"android.intent.action.MAIN\"/>" >> ${TARGET_PROJECT_PATH}/src/main/AndroidManifest.xml
		echo -e "\t\t\t<category android:name=\"android.intent.category.LAUNCHER\"/>" >> ${TARGET_PROJECT_PATH}/src/main/AndroidManifest.xml
		echo -e "\t\t</intent-filter>" >> ${TARGET_PROJECT_PATH}/src/main/AndroidManifest.xml
		echo -e "\t</activity>" >> ${TARGET_PROJECT_PATH}/src/main/AndroidManifest.xml
		echo "</application>" >> ${TARGET_PROJECT_PATH}/src/main/AndroidManifest.xml
fi
echo "</manifest>" >> ${TARGET_PROJECT_PATH}/src/main/AndroidManifest.xml

# Create the strings resources file (default)
mkdir -p ${TARGET_PROJECT_PATH}/src/main/res/values
echo "<?xml version=\"1.0\" encoding=\"utf-8\">"  >> ${TARGET_PROJECT_PATH}/src/main/res/values/strings.xml
echo "<resources>"  >> ${TARGET_PROJECT_PATH}/src/main/res/values/strings.xml
echo -e "\t<string name=\"app_name\">${PROJECT_NAME}</string>"  >> ${TARGET_PROJECT_PATH}/src/main/res/values/strings.xml
echo "</resources>"  >> ${TARGET_PROJECT_PATH}/src/main/res/values/strings.xml

# Create the build.gradle file
echo "buildscript {" >> ${TARGET_PROJECT_PATH}/build.gradle
echo -e "\trepositories {" >> ${TARGET_PROJECT_PATH}/build.gradle
echo -e "\t\tmavenCentral()" >> ${TARGET_PROJECT_PATH}/build.gradle
echo -e "\t}\n" >> ${TARGET_PROJECT_PATH}/build.gradle
echo "" >> ${TARGET_PROJECT_PATH}/build.gradle
echo -e "\tdependencies {" >> ${TARGET_PROJECT_PATH}/build.gradle
echo -e "\t\tclasspath 'com.android.tools.build:gradle:0.4.2'" >> ${TARGET_PROJECT_PATH}/build.gradle
echo -e "\t}" >> ${TARGET_PROJECT_PATH}/build.gradle
echo -e "}" >> ${TARGET_PROJECT_PATH}/build.gradle
echo -e "apply plugin: 'android'\n" >> ${TARGET_PROJECT_PATH}/build.gradle
echo "android {" >> ${TARGET_PROJECT_PATH}/build.gradle
echo -e "\tcompileSdkVersion ${PROJECT_COMPILE_SDK_VERSION}" >> ${TARGET_PROJECT_PATH}/build.gradle
echo -e "\tbuildToolsVersion \"${PROJECT_COMPILE_SDK_VERSION}\"" >> ${TARGET_PROJECT_PATH}/build.gradle
echo "}" >> ${TARGET_PROJECT_PATH}/build.gradle
