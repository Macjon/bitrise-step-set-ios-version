#!/bin/bash
set -ex

if [ -z "${pbxproj_path}" ] ; then
  echo " [!] Missing required input: pbxproj_path"
  echo " [!] Exiting..."
  exit 1
fi
if [ ! -f "${pbxproj_path}" ] ; then
  echo " [!] File project.pbxproj doesn't exist at specified path: ${pbxproj_path}"
  echo " [!] Exiting..."
  exit 1
fi

if [ -z "${info_plist_file}" ] ; then
  echo " [!] Missing required input: info_plist_file"
  echo " [!] Exiting..."
  exit 1
fi
if [ ! -f "${info_plist_file}" ] ; then
  echo " [!] File Info.plist doesn't exist at specified path: ${info_plist_file}"
  echo " [!] Exiting..."
  exit 1
fi

if [ -z "${bundle_version}" ] ; then
  echo " [!] No Bundle Version (bundle_version) specified!"
  exit 1
fi

if [ -z "${bundle_version_short}" ] ; then
  echo " [!] No Bundle Short Version String (bundle_version_short) specified!"
  exit 1
fi

echo " (i) Provided pbxproj path: ${pbxproj_path}"
echo " (i) Provided Bundle Version: ${bundle_version}"
echo " (i) Provided Bundle Short Version String: ${bundle_version_short}"


echo " (i) Setting the bundle short version to ${bundle_version_short} ..."
sed -i '' -e 's/MARKETING_VERSION \= [^\;]*\;/MARKETING_VERSION = '$bundle_version_short';/' $pbxproj_path

echo " (i) Setting the bundle version to ${bundle_version} ..."
sed -i '' -e 's/CURRENT_PROJECT_VERSION \= [^\;]*\;/CURRENT_PROJECT_VERSION = '$bundle_version';/' $pbxproj_path



/usr/libexec/PlistBuddy -c "Set :CFBundleVersion ${bundle_version}" "${info_plist_file}"
/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString ${bundle_version_short}" "${info_plist_file}"

REPLACED_BUNDLE_VERSION="$(/usr/libexec/PlistBuddy -c "Print :CFBundleVersion" "${info_plist_file}")"
echo " (i) Replaced Bundle Version: $REPLACED_BUNDLE_VERSION"
REPLACED_BUNDLE_SHORT_VERSION="$(/usr/libexec/PlistBuddy -c "Print :CFBundleShortVersionString" "${info_plist_file}")"
echo " (i) Replaced Bundle Short Version String: $REPLACED_BUNDLE_SHORT_VERSION"

envman add --key APP_BUILD --value "${REPLACED_BUNDLE_VERSION}"
envman add --key APP_VERSION --value "${REPLACED_BUNDLE_SHORT_VERSION}"