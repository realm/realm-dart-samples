![Realm](https://github.com/realm/realm-dart/raw/main/logo.png)

[![License](https://img.shields.io/badge/License-Apache-blue.svg)](LICENSE)

## A simple command-line application using [Realm Dart SDK](https://www.mongodb.com/docs/realm/sdk/flutter/#dart-standalone-realm) Flexible Sync with [Atlas App Services application](https://www.mongodb.com/docs/atlas/app-services/).
This sample demonstrates the usage of [Atlas Device Sync with Flexible Sync](https://www.mongodb.com/docs/realm/sdk/flutter/sync/) and the Realm Dart Standalone SDK.
Writing to a synced realm sends the data automatically to a linked collection in MongoDB Atas. The synced realm is subscribed to a query only for items matching specific criteria.
This causes the synced realm to be populated only with specific items matching the query.
Items in the MongoDB collection on Atlas that do not match the query do not sync to the client device.

## Realm Dart SDK

Realm Dart package is published to [realm_dart](https://pub.dev/packages/realm_dart).

## Environment setup for Realm Dart

* Realm Dart supports the platforms Windows, Mac and Linux.

* Dart SDK ^2.17.5 or newer

## Atlas App Services Configuration Steps

This sample is using an already prepared Atlas App Service with AppID `dart_flexible_sync-nxkdq`. 

If you want to create your own Atlas App Service and to have an access to the cloud App, follow the instruction below.

1. Create an account on [cloud.mongodb.com](https://cloud.mongodb.com). Follow the instructions: [Register a new Atlas Account](https://www.mongodb.com/docs/atlas/tutorial/create-atlas-account/#register-a-new-service-account).
1. Create a new app following the instructions here: [Create an App with Atlas App Services UI](https://www.mongodb.com/docs/atlas/app-services/manage-apps/create/create-with-realm-ui).
    For the purpose of this sample you don't need to create an app from a template. You can just create an empty application.
1. Go to the **Authentication** menu in the left panel and make sure the option "Allow users to log in anonymously" under `Authentication providers` tab is ON. Save and then click the button in the blue line above - `Review draft & deploy`. Read [Authentication Providers](https://www.mongodb.com/docs/atlas/app-services/authentication/providers/) for more information about the other authentication types.
1. Go to the **Device Sync** menu and [Enable Flexible Sync](https://www.mongodb.com/docs/atlas/app-services/sync/configure/enable-sync/#enable-flexible-sync).
    * Don't create a schema. Skip it by choosing "No thanks, continue to Sync".
    * Press the "Flexible Sync" button. Only Flexible Sync is supported in the Realm Dart SDK.
    * Switch ON the ["Development mode"](https://www.mongodb.com/docs/atlas/app-services/sync/data-model/development-mode/) option.
    * Create a new database collection and choose a name for it.
    * Create a new queryable field used for filtering data between both realms in this application. For our sample the fields are `status` and `progressMinutes`.
        Since it is not available in the selection list, just start writing inside the selection box and then choose `Create status`.
        It will be created.
        Do the same for the field `progressMinutes`.
    * Define permission - for the purpose of this sample please choose the option `Users can read and write all data`.
    * Click the button `Enable Sync` and confirm.
    * Click the button in the blue line above - `Review draft & deploy`, again.
2. [Find and Copy the App ID](https://www.mongodb.com/docs/atlas/app-services/reference/find-your-project-or-app-id/) of your new application.
3. Go to `tasktracker.dart` in this sample and set your App ID to the constant `appId` as follow:

    ```dart
    String appId = "tasktracker-fleld";;
    ```

These steps are for the purpose of the sample. You can follow the instructions in [MongoDB Atlas](https://www.mongodb.com/docs/atlas) for more advanced and secured configurations.

## Usage

* Get packages to the Dart application.

    ```
    dart pub get
    ```

* Install the `realm_dart` package into the application. This downloads and copies the required native binaries to the app directory.

    ```
    dart run realm_dart install
    ```

*  Run the application

    ```
    dart run
    ```

* Check the data and schema in you Atlas collection.
    * Login in [cloud.mongodb.com](https://cloud.mongodb.com) with your account.
    * Go to your application and open **Schema** menu. You can see the newly created JSON schema 
        that represents your data model defined in `model.dart` file in this sample. 
        For more details [see](https://www.mongodb.com/docs/atlas/app-services/schemas/?_ga=2.267468942.1225817147.1654079983-1571915642.1647002315&_gac=1.216786660.1654173423.CjwKCAjwv-GUBhAzEiwASUMm4jBtzETN-YJq0KELgeGLKk-4_6wVAfImtPoBbo-A35_eKjZ1p0Lh_BoCotcQAvD_BwE)
    * Go to Atlass and [browse the collection](https://www.mongodb.com/docs/atlas/atlas-ui/collections/#view-collections). All the tasks objects should be listed there.


##### The "Dart" name and logo and the "Flutter" name and logo are trademarks owned by Google. 
