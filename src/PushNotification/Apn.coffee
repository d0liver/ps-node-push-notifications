_ = require "lodash"
apn = require "apn"

exports.shutdownProvider = ({ provider }) -> -> provider.shutdown()

exports._sendApnNotification = \
	)({ provider, appId }) -> (rId) -> (title) -> \
	(body) -> (payload) -> (badgeCount) -> (opts) -> ->
	# Send iOS push notification
	note = new apn.Notification

	# Expires 1 hour from now.
	wrapper =
		alert: { title, body }
		payloadJSON: JSON.stringify(payload)
		expiry: opts.expiry
		badge: badgeCount
		sound: opts.sound
		topic: appId

	# Returns a promise
	provider.send (_.extend note, wrapper), rId

exports.initProvider = (conf) -> ->
	provider: new apn.Provider conf
	appId: conf.appId
