FCM    = require "fcm-node"
fcmKey = require "../../../../../../key.json"

fcmProvider = ->
	unless exports.fcmProvider.__memo?
		fcmProvider.__memo = new FCM fcmKey

	fcmProvider.__memo

exports._sendFcmNotification = (registrationID, alert, opts, payload) ->
	fcm = fcmProvider()
	payload.title           = alert.title
	payload.message         = alert.msg
	payload.badge           = opts.badge
	payload.style           = opts.style
	payload.summaryText     = opts.summaryText

	message =
		to: registrationID
		data: payload

	new Promise (res, rej) ->
		fcm.send message, (err, r) ->
			if err? then rej(err) else res(r)
