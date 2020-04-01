// Generated by CoffeeScript 2.5.1
var _, apn;

_ = require("lodash");

apn = require("apn");

exports._sendApnNotification = function({apn, appId}) {
  return function(rId) {
    return function(title) {
      return function(body) {
        return function(payload) {
          return function(badgeCount) {
            return function(opts) {
              return function() {
                var note, wrapper;
                // Send iOS push notification
                note = new apn.Notification();
                // Expires 1 hour from now.
                wrapper = {
                  alert: {title, body},
                  payloadJSON: JSON.stringify(payload),
                  expiry: opts.expiry,
                  badge: badgeCount,
                  sound: opts.sound,
                  topic: appId
                };
                // Returns a promise
                return apnProvider().send(_.extend(note, wrapper), rId);
              };
            };
          };
        };
      };
    };
  };
};

exports.initProvider = function(conf) {
  return function() {
    return {
      apn: new apn.Provider(conf),
      appId: conf.appId
    };
  };
};