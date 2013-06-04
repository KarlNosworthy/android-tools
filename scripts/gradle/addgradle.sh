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
# addgradle.sh <path> <compile sdk version>

if [ "$#" -lt "2" ]
	then
	echo "addgradle.sh <path> <compile sdk version>"
	exit
fi

# Set the parameters
TARGET_PROJECT_PATH="$1"
PROJECT_COMPILE_SDK_VERSION="$2"

# Create the gradle main directory structure
if [ -f "${TARGET_PROJECT_PATH}/src" ];
	then
	mkdir -p ${TARGET_PROJECT_PATH}/src/main/java
	mkdir -p ${TARGET_PROJECT_PATH}/src/main/res
fi

# Create the build.gradle file
if [ ! -f "${TARGET_PROJECT_PATH}/build.gradle" ];
	then
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
fi
