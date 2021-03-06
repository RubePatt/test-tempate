#!/usr/bin/env bash

appPath="build/ios/iphoneos/Runner.app"
payloadPath="build/ios/iphoneos/Payload"
zipPath="build/ios/iphoneos/Payload.zip"
dateTime=`date +%Y%m%d-%T`
apkPath="build/app/outputs/apk/release/app-release.apk"

outPutPath="build/all/$dateTime"

if [ ! -d "build/all" ]; then
  mkdir "build/all"
fi
if [ ! -d "$outPutPath" ]; then
  mkdir "$outPutPath"
fi

å¼å§æåiOS
echo 'ðºðºðºðº===æåiOS===ðºðºðºðº'

# å¤æ­æä»¶æ¯å¦å­å¨
echo 'æ­£å¨æ¸é¤åæä»¶'
if [ -d "$appPath" ]; then
  rm -r "$appPath"
fi
if [ -d "$zipPath" ]; then
  rm -r "$zipPath"
fi
if [ -d "$payloadPath" ]; then
  rm -r "$payloadPath"
fi
# æ¸é¤fastlaneçæå
rm -rf "app"
mkdir "app"

# iOSæå

if [[ "$1" == "dev" ]]; then
  echo 'å¼åç¯å¢å¼å§æå'
  flutter build ios -t lib/main_dev.dart --release
elif [[ "$1" == "test" ]]; then
  echo 'æµè¯ç¯å¢å¼å§æå'
  flutter build ios -t lib/main_test.dart --release
else
  echo 'çäº§ç¯å¢å¼å§æå'
  flutter build ios --release
fi

if [ -d "$appPath" ]; then
  echo 'build ios æå'
  echo 'æ­£å¨çæipaå'
   cd 'ios'
   fastlane make
   cd '..'
   if [ -f "app/æ¶æApp.ipa" ]; then
     mv "app/æ¶æApp.ipa" "$outPutPath"
     echo "çæipaæå è·¯å¾:$outPutPath"
   else
     echo 'çæipaå¤±è´¥'
   fi
else
  echo 'æåå¤±è´¥'
fi


#echo 'ðºðºðºðº===æåandroid===ðºðºðºðº'
# å¤æ­æä»¶æ¯å¦å­å¨
echo 'æ­£å¨æ¸é¤åæä»¶'
if [ -f "$apkPath" ]; then
  rm "$apkPath"
fi

# å®åæå

if [[ "$1" == "dev" ]]; then
  echo 'å¼åç¯å¢å¼å§æå'
  flutter build apk -t lib/main_dev.dart --target-platform=android-arm64
elif [[ "$1" == "test" ]]; then
  echo 'æµè¯ç¯å¢å¼å§æå'
  flutter build apk -t lib/main_test.dart --target-platform=android-arm64
else
  echo 'çäº§ç¯å¢å¼å§æå'
  flutter build apk --target-platform=android-arm64
fi

if [ -f "$apkPath" ]; then
  echo 'build akp æå'
  mv "$apkPath" "$outPutPath/æ¶æ¯éééç¨å·¥å·[$dateTime].apk"
else
  echo 'apk æåå¤±è´¥'
fi

open "$outPutPath"
echo "\033[36;1mæåæ»ç¨æ¶: ${SECONDS}s \033[0m"
