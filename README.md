# TimMaiapp
TimMaiapp is a location-based flutter app that answer one simple question: 
> How many times can I hear "Ela Partiu" of Tim Maia from my current location until a destination?

This application is part of my study of flutter framework, that led me to learn community packages, such as mapbox, device location, HTTP requests with dio, YouTube player and intl.

### Instalation

If you just want to download the app, you can click [here](https://raw.githubusercontent.com/guilhermealbm/TimMaiapp/master/app-release.apk) (make sure you have enabled the "app installation by unknown sources" option)

Otherwise, if you want to download the source code and modify it on your own computer, follow the steps below:

1. Make sure you've flutter sdk installed
2. Clone this repository:
    `git clone https://github.com/guilhermealbm/TimMaiapp`
3. Open TimMaiapp folder in your work environment
4. Create a `.env` file thats contains [map_box](https://docs.mapbox.com/) and [here_maps](https://developer.here.com/documentation) API's token

```
map_box_token = "your_token_here"
here_maps_token = "your_token_here"
```

5. Run and Enjoy

### Usage

<img src="https://raw.githubusercontent.com/guilhermealbm/TimMaiapp/master/usage.gif" width="300">
