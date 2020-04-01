apn = require "apn"

APN_PROVIDER_OPTS =
	token:
		key: Assets.absoluteFilePath("key.p8")
		keyId: "88HW4KSBHX"
		teamId: "FW2A52D3L8"
	production: true

exports._sendApnNotification = (alert, payload, opts) ->
	# Send iOS push notification
	note = new apn.Notification

	# Expires 1 hour from now.
	note.alert   = alert
	note.payload = payload
	note.expiry  = opts.expiry
	note.badge   = opts.badge
	note.sound   = opts.sound
	note.topic   = opts.topic

	# Returns a promise
	apnProvider().send note, user.iOSRegistrationID

apnProvider = ->
	unless apnProvider.__memo?
		apnProvider.__memo = new apn.Provider APN_PROVIDER_OPTS

	apnProvider.__memo
