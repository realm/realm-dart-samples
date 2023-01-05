![Realm](https://github.com/realm/realm-dart/raw/main/logo.png)

[![License](https://img.shields.io/badge/License-Apache-blue.svg)](LICENSE)

## A simple application using the [Realm Flutter SDK](https://www.mongodb.com/docs/realm/sdk/flutter/) Flexible Sync with an [Atlas App Services application](https://www.mongodb.com/docs/atlas/app-services/).
This sample demonstrates the usage of Flexible Sync based on different user permissions. 
Each user has separate realm file on the device and the data for each user is synced to the Atlas collection based on the permissions that the user has.
A user can Sign Up through the application and to choose whether to sign up as an administrator with full permissions or as a regular user.
Users with full permissions can see other users items and can change them.
The regular users can see, edit and delete only their own items.

# Realm Flutter SDK 

The Realm Flutter package is `realm` and it is available at [pub.dev](https://pub.dev/packages/realm)

# Environment

* Flutter ^3.0.3 
* Flutter Mobile on Android and iOS
* Flutter Desktop on Windows, Linux and MacOS

# Atlas App Services Configuration Steps

1. Create an account on [realm.mongodb.com](https://realm.mongodb.com) - follow the instructions: [Get Started with Atlas](https://www.mongodb.com/docs/atlas/getting-started)

## Using Realm CLI
1. Create an App using [realm-cli](https://www.mongodb.com/docs/atlas/app-services/cli/#mongodb-binary-bin.realm-cli).
1. Open command line terminal and go to the root folder of this Flutter app.
1. Install `realm-cli` following the [instructions](https://www.mongodb.com/docs/atlas/app-services/cli/#mongodb-binary-bin.realm-cli).

    `npm install -g mongodb-realm-cli`

1. Login to the realm-cli:

    `realm-cli login --api-key="<my api key>" --private-api-key="<my private api key>"`

1. Go into folder '\assets\atlas_app':

    `cd assets/atlas_app`

1. Deploy the app to Atlas App Services:

    `realm-cli push --yes`

1. Create an administrator user that to have permissions editing all the tasks:

    `flutter pub run lib/cli/run create-admin --username <admin user name> --password <admin password>`

## Using App Services UI

1. Create a new app following the instructions here: [Create an App with Atlas App Services UI](https://www.mongodb.com/docs/atlas/app-services/manage-apps/create/create-with-realm-ui).
    For the purpose of this sample you don't need to create an app from a template. You can just create an empty application.
1. Click the button in the blue line above - `Review draft & deploy`.
1. Go to the `Authentication` menu in the left panel and select :
    1. `Authentication Providers`. Then make sure the option "Email/Password" is ON. At the end click the button in the blue line above - `Review draft & deploy`. Read [this page](https://www.mongodb.com/docs/atlas/app-services/authentication/providers/) for more information about the other types of authentication.
    1. `Custom User Data`. Then make sure the option is enabled. Select cluster, database and collection where to store the custom data. Then select the field that to be used for mapping users with their custom data. For this sample the field name is `owner_id`. Read [this page](https://www.mongodb.com/docs/atlas/app-services/users/enable-custom-user-data/) for more information about enabling custom user data.
1. Go to the `Sync` menu and [Enable Flexible Sync](https://www.mongodb.com/docs/atlas/app-services/sync/configure/enable-sync/#enable-flexible-sync).
    1. Don't create a schema. Skip by choosing "No thanks, continue to Sync".
    1. Press the "Flexible Sync" button. Only Flexible Sync is supported in the Realm Flutter SDK.
    1. Switch ON the ["Development mode"](https://www.mongodb.com/docs/atlas/app-services/sync/data-model/development-mode/) option.
    1. Create a new database collection and choose a name for it.
    1. Create a new queryable field used for filtering data between both realms in this application. For our sample the field is `owner_id`.
        Since it is not available in the selection list, just start writing inside the selection box and then choose `Create owner_id`.
        It will be created.
    1. Define permission - for the purpose of this sample please choose the option `Custom` and write the following rules:
    ```json {
    {
      "rules": {
        "Item": [
          {
            "name": "admin",
            "applyWhen": {
              "%%user.custom_data.isAdmin": true
            },
            "read": true,
            "write": true
          },
          {
            "name": "user",
            "applyWhen": {
              "%%user.custom_data.isAdmin": false
            },
            "read": true,
            "write": {
              "owner_id": "%%user.id"
            }
          }
        ]
      },
      "defaultRoles": [
        {
          "name": "read-write",
          "applyWhen": {},
          "read": {
            "owner_id": "%%user.id"
          },
          "write": {
            "owner_id": "%%user.id"
          }
        }
      ]
    }
   ```
    The rules defined above allows the administrators to read/write the Items of all the users. The non-admin users will be able to read/write only their own Items. For all the other collections (like Roles for example) it is valid that users can change only the role that belongs to them. For this sample, this happens when the users register themselves.
    1. Click the button `Enable Sync` and confirm.
    1. Click the button in the blue line above - `Review draft & deploy`, again.
1. [Find and Copy the App ID](https://www.mongodb.com/docs/atlas/app-services/reference/find-your-project-or-app-id/) of your new application.
1. Go to `\assets\atlas_app\realm_config.json` in this sample and set your app_Id as follow:
    ```json{
    { .....
      "app_Id": "users_permissions-fxudl"
      .....
    }
    ```

These steps are for the purpose of the sample. You can follow the instructions.
in [MongoDB Atlas](https://www.mongodb.com/docs/atlas) for more advanced and secured configurations.

# Usage

1. Start an Android Emulator, an iPhone Simulator, attach an Android device or setup [Flutter Desktop environment](https://docs.flutter.dev/desktop)

1. Run `flutter pub get` to get all packages

1. Run `flutter run` to run the application

1. Check the data and schema in you Atlas collection.
    1. Login in [cloud.mongodb.com](https://cloud.mongodb.com) with your account.
    1. Go to your application and open `Schema` menu. You can see the newly created JSON schema that represents your data model defined in `schemas.dart` file in this sample.
        For more details [see](https://www.mongodb.com/docs/atlas/app-services/schemas/?_ga=2.267468942.1225817147.1654079983-1571915642.1647002315&_gac=1.216786660.1654173423.CjwKCAjwv-GUBhAzEiwASUMm4jBtzETN-YJq0KELgeGLKk-4_6wVAfImtPoBbo-A35_eKjZ1p0Lh_BoCotcQAvD_BwE)
    1. See in this document how to [browse the collections in Atlas](https://www.mongodb.com/docs/atlas/atlas-ui/collections/#view-collections).


##### The "Dart" name and logo and the "Flutter" name and logo are trademarks owned by Google. 