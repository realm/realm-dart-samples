<picture>
    <source srcset="https://github.com/realm/realm-dart/raw/main/media/logo-dark.svg" media="(prefers-color-scheme: dark)" alt="realm by MongoDB">
    <img src="https://github.com/realm/realm-dart/raw/main/media/logo.svg" alt="realm by MongoDB">
</picture>

[![License](https://img.shields.io/badge/License-Apache-blue.svg)](LICENSE)

# Users permissions sample

A simple application using the [Realm Flutter SDK](https://www.mongodb.com/docs/realm/sdk/flutter/) Flexible Sync with an [Atlas App Services application](https://www.mongodb.com/docs/atlas/app-services/).

This sample demonstrates the usage of Flexible Sync based on different user permissions. 
Each user has separate realm file on the device and the data for each user is synced to the Atlas collection based on the permissions that the user has.

A user can Sign Up through the application as a regular user.

The administrators can be created using a cli command `create-admin` that could be found in the `Usage` section - `Create administrator using Realm SDK`.

Users with full permissions (the administrators) can see other users` items and can edit/delete them.

The regular users can see other users` items but are not allowed to edit/delete them. They can edit/delete only their own items.

## Realm Flutter SDK 

Realm Flutter package is published to [realm](https://pub.dev/packages/realm).

## Environment

* Realm Flutter supports the platforms iOS, Android, Windows, MacOS and Linux.

* Flutter 3.10.2 or newer
* For Flutter Desktop environment setup, see [Desktop support for Flutter](https://docs.flutter.dev/desktop).

## Creating a new Atlas App Services.

For the purpose of this demo you have to create your own Atlas App Service. Follow the instructions below.

1. Create an account on [realm.mongodb.com](https://realm.mongodb.com) - follow the instructions: [Get Started with Atlas](https://www.mongodb.com/docs/atlas/getting-started)
1. You can create your Atlas App using `Realm CLI` or using `App Service UI`.

### Using Realm CLI

1. Create an App using [realm-cli](https://www.mongodb.com/docs/atlas/app-services/cli/#mongodb-binary-bin.realm-cli).
1. Open command line terminal and go to the root folder of this Flutter app.
1. Install `realm-cli` following the [instructions](https://www.mongodb.com/docs/atlas/app-services/cli/#mongodb-binary-bin.realm-cli).

    `npm install -g mongodb-realm-cli`

1. Login to the realm-cli:

    `realm-cli login --api-key="<my api key>" --private-api-key="<my private api key>"`

1. Go into folder '\assets\atlas_app':

    `cd assets/atlas_app`
1. Deploy the app to Atlas App Services:
* IMPORTANT: Before to push the app make sure the cluster name is the same like the cluster in your account. Go to "\assets\atlas_app\data_sources\mongodb-atlas\config.json" and set the json field `clusterName`.
Then run this command:

    `realm-cli push --yes`

1. Create a new user for administrator.

    `realm-cli users create  --app users_permissions --type email --email <username or email> --password <password>`

1. Get the useId from this list and copy it.

    `realm-cli users list --provider="local-userpass" --app users_permissions`

1. Set user role as an Administrator by passing `--args true` to the following function.

    `realm-cli function run --name setUserRole --args true --user <copied useId> --app users_permissions`


### Using App Services UI

1. Create a new app following the instructions here: [Create an App with Atlas App Services UI](https://www.mongodb.com/docs/atlas/app-services/manage-apps/create/create-with-realm-ui).
    For the purpose of this sample you don't need to create an app from a template. You can just create an empty application.
1. Click the button **Review draft & deploy**.
1. Go to the **Sync** menu and [Enable Flexible Sync](https://www.mongodb.com/docs/atlas/app-services/sync/configure/enable-sync/#enable-flexible-sync).
    1. Don't create a schema. Skip by choosing "No thanks, continue to Sync".
    1. Press the **Flexible Sync** button. Only Flexible Sync is supported in the Realm Flutter SDK.
    1. Switch ON the [Development mode](https://www.mongodb.com/docs/atlas/app-services/sync/data-model/development-mode/) option.
    1. Create a new database collection and choose a name for it.
    1. Create a new queryable field used for setting App Service permissions. For our sample, the field is `owner_id`.
        Type the field name `owner_id` in the selection box and then choose `Create owner_id` to create it.
        * Click the button **Enable Sync** and confirm.
        * Click the button **Review draft & deploy**, again.
        * The queryable field can be [automatically created in development mode](https://www.mongodb.com/docs/atlas/app-services/sync/configure/sync-settings/#queryable-fields) when it is part of the sync subscriptions, but for this sample we create it manually in order to use it for setting the permissions as it is described below.
1. Go to the **Authentication** menu in the left panel and select :
    1. `Authentication Providers`. Then make sure the option "Email/Password" is ON. Save and then click the button **Review draft & deploy**. Read [this page](https://www.mongodb.com/docs/atlas/app-services/authentication/providers/) for more information about the other types of authentication.
    1. `Custom User Data`. Then make sure the option is enabled. Select cluster, database and collection where to store the custom data. Choose collection name `Role`. Then select the field that to be used for mapping users with their custom data. For this sample the field name is `owner_id`. Read [this page](https://www.mongodb.com/docs/atlas/app-services/users/enable-custom-user-data/) for more information about enabling custom user data.
1. Go to the **Rules** menu.
    1. Select "Default roles and filters" under the service name. Choose from the list with `Other preset`: `readOwnWriteOwn (User can only read and write their own data)` and click the button **Add preset role**. If you switch to `Advanced view` the JSON should looks like the one in the file `/assets/atlas_app/data_sources/mongodb-atlas/default_rule.json`.
    1. To set specific permissions to a collection, it must exist. Create a new collection with name "Item" if it doesn't exist. This could be done from the menu option `Create collection`, which is on the root level next to the service name. Then select the collection and set the rules. Choose from the list with `Other preset`: `Users can read and write their own data, admins can read and write all data`.
    * Edit `admin` role: 
      * Set `applyWhen` as follows:

        ```json
        "apply_when": {
            "%%user.custom_data.isAdmin": true
          }
        ```
      * Set Document permisions: Read:`true` and Write:`true`.
    * Edit `user` role:
      * Set applyWhen as follow:
        ```json
        "apply_when": {
            "%%user.custom_data.isAdmin": false
          }
        ```
      * Set Document permisions: Read:`true` and Write: as follow.
        ```json
          {
            "owner_id": "%%user.id"
          }
        ```

    If you switch to Advanced view the json should looks like the one in this file: /assets/atlas_app/data_sources/mongodb-atlas/user_permissions/Item/rules.json.
    The rules defined above allows the administrators to read/write the Items of all the users. The non-admin users will be able to read/write only their own Items. For all the other collections (like Roles for example) it is valid that users can change only the role that belongs to them. For this sample, this happens when the users register themselves.
    1. Click the button **Save dtaft** and confirm.
    1. Click the button **Review draft & deploy**.
1. [Find and Copy the App ID](https://www.mongodb.com/docs/atlas/app-services/reference/find-your-project-or-app-id/) of your new application.
1. Go to `/assets/atlas_app/realm_config.json` in this sample and set your `app_id` as follows:
    ```json
    { .....
      "app_id": "users_permissions-xxxxx"
      .....
    }
    ```

1. Create an administrator with full permissions for editing all the tasks in the Flutter app:

    Follow the instructions in the section [Create administrator using Realm SDK](#create-administrator-using-realm-sdk).

These steps are for the purpose of the sample. You can follow the instructions.
in [MongoDB Atlas](https://www.mongodb.com/docs/atlas) for more advanced and secured configurations.

## Usage

### Run the Flutter App

1. Start an Android Emulator, an iPhone Simulator, attach an Android device or setup [Flutter Desktop environment](https://docs.flutter.dev/desktop)

1. Run `flutter pub get` to get all packages

1. Run `flutter run` to run the application

### Create administrator using Realm SDK

* For creating an administrator with full permissions run these commands:

    `dart run realm install`

    `dart run lib/cli/run.dart create-admin --username <admin user name> --password <admin password>`

### Browse the collection in Atlas

* Check the data and schema in you Atlas collection.
    1. Login in [cloud.mongodb.com](https://cloud.mongodb.com) with your account.
    1. Go to your application and open `Schema` menu. You can see the newly created JSON schema that represents your data model defined in `schemas.dart` file in this sample.
        For more details [see](https://www.mongodb.com/docs/atlas/app-services/schemas/?_ga=2.267468942.1225817147.1654079983-1571915642.1647002315&_gac=1.216786660.1654173423.CjwKCAjwv-GUBhAzEiwASUMm4jBtzETN-YJq0KELgeGLKk-4_6wVAfImtPoBbo-A35_eKjZ1p0Lh_BoCotcQAvD_BwE)
    1. See in this document how to [browse the collections in Atlas](https://www.mongodb.com/docs/atlas/atlas-ui/collections/#view-collections).


##### The "Dart" name and logo and the "Flutter" name and logo are trademarks owned by Google.