_ = require "lodash"
FCM = require "fcm-node"

exports.initProvider = ({ keyFilePath }) -> -> new FCM (require keyFilePath)
exports._sendFcmNotification = \
	(fcm) -> (rId) -> (title) -> (body) -> \
	(payload) -> (badgeCount) -> (opts) -> ->
	wrapper =
		to: rId
		data:
			title: title
			message: body
			badge: badgeCount
			style: opts.style
			summaryText: opts.summaryText
			payloadJSON: JSON.stringify(payload)

	new Promise (res, rej) ->
		fcm.send wrapper, (err, r) ->
			if err? then rej(err) else res(r)
