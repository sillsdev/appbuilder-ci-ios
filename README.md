# appbuilder-ci-ios

### Description

The `appbuilder-ci-ios` is the CI build description for the Scriptoria project. This project provides a way for iOS apps to be be remotely signed after they have been built by `appbuilder-buildengine-api` on AWS CodeBuild using `docker-appbuilder-agent`.

### Travis CI

To trigger a build using [Travis](https://travis-ci.org), clone this repo and [Trigger a build using the Travis API](https://docs.travis-ci.com/user/triggering-builds/).

The body of the request should look something like this:
```
{
  "request" : {
    "branch":"master",
    "message":"Build Message",
    "config" : {
      "merge_mode" : "deep_merge_prepend",
      "env": {
        "global" : [
          "APPBUILDER_ASSET=WEB-1.4.ipa",
          "APPBUILDER_ASSET_DOWNLOAD_PATH=s3://sil-stg-aps-files/stg/jobs/build_scriptureappbuilder_0/1",
          "APPBUILDER_ASSET_RESULT_PATH=s3://sil-stg-aps-files/stg/jobs/build_scriptureappbuilder_0/1/signed",
          "APPBUILDER_SECRETS_PATH=s3://sil-stg-aps-secrets/jenkins/build/apple_app_store/bluevire"
        ]
      }
    }
  }
}
```


