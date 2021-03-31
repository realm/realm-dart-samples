## A simple command-line application using Realm Dart SDK

## Setup

* Dart SDK 2.12 stable is required from https://dart.dev/.

    **Do not use the Dart SDK downloaded with Flutter 2.0 since it has issues and will not be able to run this sample**

    Download Dart SDK 2.12 stable from here  https://dart.dev/tools/sdk/archive unzip it and add the directory to the PATH before the Flutter path.
    
    * On Mac

    ```
    export /Users/<YOUR_PATH>/dart-sdk.2.12.0/bin:$PATH
    ```

    * On Windows

    ```
    set PATH=C:\<YOUR_PATH>\dartsdk-windows-x64-release-2.12.0\bin;%PATH% 
    ```

*  Get all dependencies
    ```
    dart pub get
    ```
* Install Realm Dart binary into the application

    ```
    dart run realm_dart install
    ```
* [Optional] Generate Realm Realm data model classes
    
    This is needed only to regenerate Realm data model classes if they changed. 
    If asked select `Delete` to delete any conflicts.

    ```
    dart run build_runner build
    ``` 
*  Run the application

    ```
    dart run myapp
    ```

##### The "Dart" name and logo and the "Flutter" name and logo are trademarks owned by Google. 

