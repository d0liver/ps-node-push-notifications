_ = require "lodash"
FCM = require "fcm-node"

exports._initProvider = ({ tag, contents }) -> ->
	switch tag
		when "KeyFilePath" then new FCM (require contents.keyFilePath)
		when "KeyObj" then new FCM (contents.private_key)

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
