![Realm](https://github.com/realm/realm-dart/raw/main/logo.png)

[![License](https://img.shields.io/badge/License-Apache-blue.svg)](LICENSE)
# Flutter Flexible Sync sample

A simple application using the [Realm Flutter SDK](https://www.mongodb.com/docs/realm/sdk/flutter/) Flexible Sync with an [Atlas App Services application](https://www.mongodb.com/docs/atlas/app-services/).

Writing to a synced realm named db_allTasks.realm syncs the data automatically to a linked MongoDB collection on Atlas.
Then sample demonstrates working with two subscription queries for important tasks and normal tasks in two different realms.

## Realm Flutter SDK 

Realm Flutter package is published to [realm](https://pub.dev/packages/realm).

## Environment

* Realm Flutter supports iOS, Android, Windows, MacOS and Linux platforms.

* Flutter ^3.0.3 or newer
* For Flutter Desktop environment setup, see [Desktop support for Flutter](https://docs.flutter.dev/desktop).

## Atlas App Services Configuration Steps

### Using existing demo App Service

This sample is using an already prepared Atlas App Service with AppID `flutter_flexible_sync-bnrih`.
The app_id is configured in "\assets\atlas_app\realm_config.json"

### Creating a new App Service

If you want to create an Atlas App Service and have an access to the cloud App, follow the instruction below.

1. Create an account on [cloud.mongodb.com](https://cloud.mongodb.com). Follow the instructions: [Register a new Atlas Account](https://www.mongodb.com/docs/atlas/tutorial/create-atlas-account/#register-a-new-service-account).

#### Using Realm CLI
1. Create an App using [realm-cli](https://www.mongodb.com/docs/atlas/app-services/cli/#mongodb-binary-bin.realm-cli).
1. Open a terminal in the root folder of the sample.
1. Install `realm-cli` following the [instructions](https://www.mongodb.com/docs/atlas/app-services/cli/#mongodb-binary-bin.realm-cli).

    `npm install -g mongodb-realm-cli`

1. Login to the realm-cli:

    `realm-cli login --api-key="<my api key>" --private-api-key="<my private api key>"`

1. Go into folder '\assets\atlas_app':

    `cd assets/atlas_app`

1. Deploy the app to Atlas App Services:
* IMPORTANT: Before pushing the app make sure the cluster name is the same like the cluster in your account. Go to "\assets\atlas_app\data_sources\mongodb-atlas\config.json" and set the json field `clusterName`.
Then run this command:

    `realm-cli push --yes`

#### Using App Services UI

1. Create a new app following the instructions here: [Create an App with Atlas App Services UI](https://www.mongodb.com/docs/atlas/app-services/manage-apps/create/create-with-realm-ui).
    For the purpose of this sample you don't need to create an app from a template. You can just create an empty application.
1. Go to the **Authentication** menu in the left panel and make sure the option "Allow users to log in anonymously" under `Authentication providers` tab is ON. Save and then click the button **Review draft & deploy**. Read [Authentication Providers](https://www.mongodb.com/docs/atlas/app-services/authentication/providers/) for more information about the other authentication types.
1. Go to the **Rules** menu and select "Default roles and filters" under the service name. Choose `readAndWriteAll` and click the button **Add preset role**. Click the button **Save draft** and confirm. Then click the button **Review draft & deploy**.
1. Go to the **Device Sync** menu and [Enable Flexible Sync](https://www.mongodb.com/docs/atlas/app-services/sync/configure/enable-sync/#enable-flexible-sync).
    * Don't create a schema. Skip it by choosing "No thanks, continue to Sync".
    * Press the "Flexible Sync" button. Only Flexible Sync is supported in the Realm Flutter SDK.
    * Switch ON the ["Development mode"](https://www.mongodb.com/docs/atlas/app-services/sync/data-model/development-mode/) option.
    * Create a new database collection and choose a name for it.
    * The queryable fields used for filtering data between two realms in this application and they will be [automatically created in development mode](https://www.mongodb.com/docs/atlas/app-services/sync/configure/sync-settings/#queryable-fields), because they are used in the sync subscriptions.
    * You can also create them manually from the UI. For this sample the field is `isImportant`.
        Type the field name `isImportant` in the selection box and then choose `Create isImportant`.
        It will be created.
    * Click the button **Enable Sync** and confirm.
    * Click the button **Review draft & deploy**, again.
1. [Find and Copy the App ID](https://www.mongodb.com/docs/atlas/app-services/reference/find-your-project-or-app-id/) of your new application.
1. Go to `\assets\atlas_app\realm_config.json` in this sample and set your app_Id as follow:
    ```json{
    { .....
      "app_id": "flutter_flexible_sync-rmjux"
      .....
    }
    ```

These steps are for the purpose of the sample. You can follow the instructions in [MongoDB Atlas](https://www.mongodb.com/docs/atlas) for more advanced and secured configurations.

## Usage

* Start an Android Emulator, an iPhone Simulator, attach an Android device or setup [Flutter Desktop environment](https://docs.flutter.dev/desktop)

* Run `flutter pub get` to get all packages

* Run `flutter run` to run the application

* Check the data and schema in you Atlas collection.
    * Login in [cloud.mongodb.com](https://cloud.mongodb.com) with your account.
    * Go to your application and open `Schema` menu. You can see the newly created JSON schema 
        that represents your data model defined in `model.dart` file in this sample. 
        For more details [see](https://www.mongodb.com/docs/atlas/app-services/schemas/?_ga=2.267468942.1225817147.1654079983-1571915642.1647002315&_gac=1.216786660.1654173423.CjwKCAjwv-GUBhAzEiwASUMm4jBtzETN-YJq0KELgeGLKk-4_6wVAfImtPoBbo-A35_eKjZ1p0Lh_BoCotcQAvD_BwE)
    * Go to Atlass and [browse the collection](https://www.mongodb.com/docs/atlas/atlas-ui/collections/#view-collections). All the tasks objects should be listed there.


##### The "Dart" name and logo and the "Flutter" name and logo are trademarks owned by Google. 