## 1.INSTALLATION

- Flutter Installation
  -> download the flutter file according to your OS. [Flutter Link](https://docs.flutter.dev/get-started/install)
or you can can use brew command
``` bash
brew install --cask flutter
```
- VS Code Installation -> Use [this link](https://code.visualstudio.com/Download) to download VS Code / use brew command 
``` bash
brew install --cask visual-studio-code
```
- Install Android Studio -> use [this link](https://developer.android.com/studio) to download Android Studio / use brew command
``` bash
brew install --cask android-studio
```
- Install Emulator using -> [link](https://developer.android.com/studio/run/emulator).

## APP SETUP
1. Open Project and Open Terminal. You can use shortcup key `(Ctrl + `)` and type command given below:
```
flutter pub get
```
this command will install all the dependencies required to run the app.

2. Creat .env file in the main Directory of the app and put your API key in that file like:
```
API_KEY = {YOUR API KEY HERE}
```
save and close this file.

3. write commands given below to run the app
```
flutter clean
flutter run
```
these two commands will clean and make sure that there are no errors while building and running the app.

4. Make sure that you have emulator or Hardware device to run the app.
