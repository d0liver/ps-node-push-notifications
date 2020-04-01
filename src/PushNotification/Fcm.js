// Generated by CoffeeScript 2.5.1
var FCM, _;

_ = require("lodash");

FCM = require("fcm-node");

exports.initProvider = function({keyPath}) {
  return function() {
    return new FCM(require(keyPath));
  };
};

exports._sendFcmNotification = function(fcm) {
  return function(rId) {
    return function(title) {
      return function(body) {
        return function(payload) {
          return function(badgeCount) {
            return function(opts) {
              return function() {
                var wrapper;
                wrapper = {
                  to: rId,
                  data: {
                    title: title,
                    message: body,
                    badge: badgeCount,
                    style: opts.style,
                    summaryText: opts.summaryText,
                    payloadJSON: JSON.stringify(payload)
                  }
                };
                return new Promise(function(res, rej) {
                  return fcm.send(wrapper, function(err, r) {
                    if (err != null) {
                      return rej(err);
                    } else {
                      return res(r);
                    }
                  });
                });
              };
            };
          };
        };
      };
    };
  };
};
