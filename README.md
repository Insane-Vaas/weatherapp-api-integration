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

## APP Screen Shots

- Put name of the city to search and know about the weather
![Simulator Screen Shot - iPhone 13 Pro - 2022-08-24 at 23 25 45](https://user-images.githubusercontent.com/46975685/186500592-41f2ad6f-dc4b-4544-869e-906514e6adfe.png)

- Press the Search button and you will get the info about city's weather
![Simulator Screen Shot - iPhone 13 Pro - 2022-08-24 at 23 25 33](https://user-images.githubusercontent.com/46975685/186500752-3e4568f6-c05e-45da-80fc-469eba6090ff.png)

- to know about future forecasts
![Simulator Screen Shot - iPhone 13 Pro - 2022-08-24 at 23 24 58](https://user-images.githubusercontent.com/46975685/186500862-c4ddf50e-c231-4693-8cb1-b00f76987baf.png)

- Error Screen you will get when you type wrong city name.
![Simulator Screen Shot - iPhone 13 Pro - 2022-08-24 at 23 25 09](https://user-images.githubusercontent.com/46975685/186500933-7f1a235d-f1e8-4a3d-add8-95665bc3144f.png)



