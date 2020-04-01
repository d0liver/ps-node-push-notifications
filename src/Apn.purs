module PushNotification.Apn (
  ApnOpts, Sound,
  defaultApnOpts, unsafeSendApnNotification
) where

import Prelude

import Control.Promise (Promise)
import Control.Promise as Promise
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Foreign (Foreign)
import Moment (Duration, Increment(..), duration)
import Meteor.User (RegistrationID)

type Payload = Foreign

-- Could error
foreign import _sendApnNotification :: Alert -> Payload -> ApnOpts -> Effect (Promise Unit)

unsafeSendApnNotification :: Alert -> Payload -> ApnOpts -> Aff Unit
unsafeSendApnNotification alert payload opts =
  liftEffect (_sendApnNotification alert payload opts)
  >>= Promise.toAff

data Sound = Ping

instance showSound :: Show Sound where
  show Ping = "ping.aiff"

type Alert = {
   title :: String,
   body :: String,
   iOSRegistrationID :: RegistrationID
}

type RawAlert = {
  title :: String,
  body :: String,
  iOSRegistrationID :: String
}

type ApnOpts = {
  expirty :: Duration,
  badge :: Int,
  sound :: Sound,
  -- TODO: We probably shouldn't be dumping Foreign stuff directly.
  payload :: Foreign,
  topic :: String
}

type RawApnOpts = {
  expiry :: Int,
  badge :: Int,
  sound :: Sound,
  payload :: Foreign,
  topic :: String
}

defaultApnOpts :: { badgeCount :: Int
 , expiry :: Duration
 , sound :: String
 , topic :: String
 }
defaultApnOpts = {
  expiry: duration 1 Hours,
  badgeCount: 0,
  sound: "ping.aiff",
  topic: "com.playprimacy.primacy"
}
