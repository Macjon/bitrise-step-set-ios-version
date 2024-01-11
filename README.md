# Set iOS version

With this step we replace the values of MARKETING_VERSION and CURRENT_PROJECT_VERSION in the project.pbxproj file. The project.pbxproj file is located in your .xcodeproj file.

## How to use this Step in your bitrise.yml file

Reference it in your `bitrise.yml` with the `git::PUBLIC-GIT-CLONE-URL@BRANCH` step reference style:

```
- git::https://github.com/Macjon/bitrise-step-set-ios-version.git@main:
   inputs:
        - bundle_version: "The bundle version"
        - bundle_version_short: "The short bundle version"
        - pbxproj_path: "Path to {Project name}/project.pbxproj"
```

## Share your own Step

You can share your Step or step version with the [bitrise CLI](https://github.com/bitrise-io/bitrise). If you use the `bitrise.yml` included in this repository, all you have to do is:

1. In your Terminal / Command Line `cd` into this directory (where the `bitrise.yml` of the step is located)
1. Run: `bitrise run test` to test the step
1. Run: `bitrise run audit-this-step` to audit the `step.yml`
1. Check the `share-this-step` workflow in the `bitrise.yml`, and fill out the
   `envs` if you haven't done so already (don't forget to bump the version number if this is an update
   of your step!)
1. Then run: `bitrise run share-this-step` to share the step (version) you specified in the `envs`
1. Send the Pull Request, as described in the logs of `bitrise run share-this-step`

That's all ;)
