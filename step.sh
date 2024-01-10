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

if [ -z "${bundle_version}" ] ; then
  echo " [!] No Bundle Version (bundle_version) specified!"
fi

if [ -z "${bundle_version_short}" ] ; then
  echo " [!] No Bundle Short Version String (bundle_version_short) specified!"
fi

echo " (i) Provided pbxproj path: ${pbxproj_path}"
echo " (i) Provided Bundle Version: ${bundle_version}"
echo " (i) Provided Bundle Short Version String: ${bundle_version_short}"


echo " Setting the bundle short version to ${bundle_version_short} ..."
sed -i '' -e 's/MARKETING_VERSION \= [^\;]*\;/MARKETING_VERSION = '$bundle_version_short';/' $pbxproj_path

echo " Setting the bundle version to ${bundle_version} ..."
sed -i '' -e 's/CURRENT_PROJECT_VERSION \= [^\;]*\;/CURRENT_PROJECT_VERSION = '$bundle_version';/' $pbxproj_path

echo "-------------"
echo "| All done! |"
echo "-------------"

