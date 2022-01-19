var exec = require("cordova/exec");

var PLUGIN_NAME = "CoinkWebview";

var CoinkWebview = {
    openWebview: function(url = "", disabled = false, successCallback, errorCallback) {
        exec(
            successCallback,
            errorCallback,
            PLUGIN_NAME,
            "openWebview",
            [url, disabled]
        );
    },
};
module.exports = CoinkWebview;
