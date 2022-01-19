# Cordova Plugin Webview Coink

Cordova plugin webview for Coink

## Install

Run in terminal `ionic cordova plugin add git@gitlab.bancoink.biz:front-end/cordova-plugin-webview-coink.git`

Enjoy!

## Use

Example use

``` javascript
declare let cordova: any;
// First param - string - the url
// Second param - boolean - disable backButton and forwardButton
// Return callback format {code: number, message: string}
cordova.plugins.CoinkWebview.openWebview(this.url, false, (success) => console.log(JSON.parse(success)), (error) => { console.log(JSON.parse(error))});
```

Callback codes

- Code 0: Error open webview
- Code 1: Handle close button
