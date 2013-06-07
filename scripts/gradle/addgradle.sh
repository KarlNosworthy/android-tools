#!/bin/bash
#
# Feel free to take, distribute, copy, install, rename, modify or
# enhance this script. I hope it comes in handy. If you have ideas
# to make it better...you know where it came from.
#
# addgradle							   			created: 4/06/2013
# ================================================================
#
# A simple utility to add gradle structure and initial configuration
# to an existing android project.
#
# addgradle.sh <path> <compile sdk version> [library project <Y/N>] [gradle version] [android plugin version]

if [ "$#" -lt "2" ]
	then
	echo "addgradle.sh <path> <compile sdk version> [library project <Y/N>] [gradle version] [android plugin version] "
	exit
fi

# Set the parameters
TARGET_PROJECT_PATH="$1"
PROJECT_COMPILE_SDK_VERSION="$2"

if [ -z "$3" ]
	then
	PROJECT_IS_LIBRARY="N"
else
	PROJECT_IS_LIBRARY="Y"
fi

if [ -z "$4"]
	then
	GRADLE_VERSION="1.6"
else
	GRADLE_VERSION="$4"
fi

if [ -z "$5" ]
	then
	ANDROID_PLUGIN_VERSION="0.4.2"
else
	ANDROID_PLUGIN_VERSION="$5" 
fi

#
echo -ne "\n"
echo " Gradle configuration - Version:                ${GRADLE_VERSION}"
echo -e "                        Android Plugin Version: ${ANDROID_PLUGIN_VERSION}\n"
echo -n "   > Adding gradle support to project"

# Create the gradle main directory structure
mkdir -p ${TARGET_PROJECT_PATH}/src/main/java
mkdir -p ${TARGET_PROJECT_PATH}/src/main/res

echo -e "\t\t\t\t\t [done]"
echo -n "   > Generating build.gradle"

# Create the build.gradle file
if [ ! -f "${TARGET_PROJECT_PATH}/build.gradle" ];
	then
	echo "buildscript {" >> ${TARGET_PROJECT_PATH}/build.gradle
	echo -e "\trepositories {" >> ${TARGET_PROJECT_PATH}/build.gradle
	echo -e "\t\tmavenCentral()" >> ${TARGET_PROJECT_PATH}/build.gradle
	echo -e "\t}\n" >> ${TARGET_PROJECT_PATH}/build.gradle
	echo "" >> ${TARGET_PROJECT_PATH}/build.gradle
	echo -e "\tdependencies {" >> ${TARGET_PROJECT_PATH}/build.gradle
	echo -e "\t\tclasspath 'com.android.tools.build:gradle:${ANDROID_PLUGIN_VERSION}'" >> ${TARGET_PROJECT_PATH}/build.gradle
	echo -e "\t}" >> ${TARGET_PROJECT_PATH}/build.gradle
	echo -e "}" >> ${TARGET_PROJECT_PATH}/build.gradle
	echo -e "task wrapper(type: Wrapper) {\n\tgradleVersion = '${GRADLE_VERSION}'\n}" >> ${TARGET_PROJECT_PATH}/build.gradle
	if [ "${PROJECT_IS_LIBRARY}" == "Y" ]
		then
		echo -e "apply plugin: 'android-library'\n" >> ${TARGET_PROJECT_PATH}/build.gradle
	else
		echo -e "apply plugin: 'android'\n" >> ${TARGET_PROJECT_PATH}/build.gradle
	fi
	echo "android {" >> ${TARGET_PROJECT_PATH}/build.gradle
	echo -e "\tcompileSdkVersion ${PROJECT_COMPILE_SDK_VERSION}" >> ${TARGET_PROJECT_PATH}/build.gradle
	echo -e "\tbuildToolsVersion \"${PROJECT_COMPILE_SDK_VERSION}\"" >> ${TARGET_PROJECT_PATH}/build.gradle
	echo "}" >> ${TARGET_PROJECT_PATH}/build.gradle
fi
echo -e "\t\t\t\t\t\t [done]"
