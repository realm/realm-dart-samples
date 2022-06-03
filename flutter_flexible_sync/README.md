![Realm](https://github.com/realm/realm-dart/raw/master/logo.png)

[![License](https://img.shields.io/badge/License-Apache-blue.svg)](LICENSE)

## A simple application using the [Realm Flutter SDK](https://www.mongodb.com/docs/realm/sdk/flutter/) Flexible Sync with an [Atlas App Services application](https://www.mongodb.com/docs/atlas/app-services/).
This sample demonstrates the usage of Flexible Sync. 
Writing to a local realm named `db_allTasks.realm` sends the data automatically to the Atlas collection.
Then the data are downloaded back by the synchronization process to two separate realms
 `db_importantTasks.realm` and  `db_normalTaks.realm` filtered by specific subscription query.

# Realm Flutter SDK 

The Realm Flutter package is `realm` and it is available at [pub.dev](https://pub.dev/packages/realm)

# Environment

* Flutter ^3.0.1 
* Flutter Mobile on Android and iOS
* Flutter Desktop on Windows, Linux and MacOS

# Atlas App Services Configuration Steps

* Create an account on [realm.mongodb.com](https://realm.mongodb.com) - follow the instructions: [Get Started with Atlas](https://www.mongodb.com/docs/atlas/getting-started)
* Create a new app following the instructions here: [Create an App with Atlas App Services UI](https://www.mongodb.com/docs/atlas/app-services/manage-apps/create/create-with-realm-ui).
    For the purpose of this sample you don't need to create an app from a template. You can just create an empty application.
* Click the button in the blue line above - `Review draft & deploy`.
* Go to the `Authentication Providers` menu in the left panel and make sure the option "Allow users to log in anonymously" is ON.
    Read [this page](https://www.mongodb.com/docs/atlas/app-services/authentication/providers/) for more information about the other types of authentication.
* Go to the `Sync` menu and [Enable Flexible Sync](https://www.mongodb.com/docs/atlas/app-services/sync/configure/enable-sync/#enable-flexible-sync).
    * Don't create a schema. Skip by choosing "No thanks, continue to Sync".
    * Press the "Flexible Sync" button. Only Flexible Sync is supported in the Realm Flutter SDK.
    * Switch ON the ["Development mode"](https://www.mongodb.com/docs/atlas/app-services/sync/data-model/development-mode/) option. 
    * Create a new database collection and choose a name for it.
    * Create a new queryable field used for filtering data between both realms in this application. For our sample the field is `isImportant`. 
        Since it is not available in the selection list, just start writing inside the selection box and then choose `Create isImportant`. 
        It will be created.
    * Define permission - for the purpose of this sample please choose the option `Users can read and write all data`.
    * Click the button `Enable Sync` and confirm.
    * Click the button in the blue line above - `Review draft & deploy`, again.
* Copy the App ID of your new application. Follow [Find an App ID](https://www.mongodb.com/docs/atlas/app-services/reference/find-your-project-or-app-id/?_ga=2.267445390.1225817147.1654079983-1571915642.1647002315&_gac=1.229371374.1654173423.CjwKCAjwv-GUBhAzEiwASUMm4jBtzETN-YJq0KELgeGLKk-4_6wVAfImtPoBbo-A35_eKjZ1p0Lh_BoCotcQAvD_BwE#find-an-app-id)
* Go to `main.dart` in this sample and set your App ID to the constant `appId` as follow: 
    ```dart
    const String appId = "flutter_flx_sync-plfhm";
    ```

These steps are for the purpose of the sample. You can follow the instructions 
in [MongoDB Atlas](https://www.mongodb.com/docs/atlas) for more advanced and secured configurations.

# Usage

* Start an Android Emulator, an iPhone Simulator, attach an Android device or setup [Flutter Desktop environment](https://docs.flutter.dev/desktop)

* Run `flutter pub get` to get all packages

* Run `flutter run` to run the application

* Check the data and schema in you Atlas collection.
    * Login in [realm.mongodb.com](https://realm.mongodb.com) with your account.
    * Go to your application and open `Schema` menu. You can see the newly created JSON schema 
        that represents your data model defined in `model.dart` file in this sample. 
        For more details [see](https://www.mongodb.com/docs/atlas/app-services/schemas/?_ga=2.267468942.1225817147.1654079983-1571915642.1647002315&_gac=1.216786660.1654173423.CjwKCAjwv-GUBhAzEiwASUMm4jBtzETN-YJq0KELgeGLKk-4_6wVAfImtPoBbo-A35_eKjZ1p0Lh_BoCotcQAvD_BwE)
    * Go to Atlass and [browse the collection](https://www.mongodb.com/docs/atlas/atlas-ui/collections/#view-collections). All the tasks objects should be listed there.


##### The "Dart" name and logo and the "Flutter" name and logo are trademarks owned by Google. 