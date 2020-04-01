module PushNotification.Fcm (
  Alert, FcmOpts, Style,
  defaultFcmOpts,
  unsafeSendFcmNotification
) where

import Prelude

import Control.Promise (Promise)
import Control.Promise as Promise
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Foreign (Foreign)
import Foreign.Generic.Class (encode)
import Foreign.Object (Object)
import Meteor.User (RegistrationID)

type Payload = Object

-- Could error
foreign import _sendFcmNotification :: RawAlert -> RawFcmOpts -> Foreign -> Effect (Promise Unit)

unsafeSendFcmNotification :: Alert -> FcmOpts -> Foreign -> Aff Unit
unsafeSendFcmNotification alert opts payload =
  liftEffect (_sendFcmNotification
    (buildAlert alert)
    (buildFcmOpts opts)
    (encode payload)
  ) >>= Promise.toAff

data Style = Inbox
instance showStyle :: Show Style where
  show Inbox = "inbox"

type FcmOpts = {
  badge :: Int,
  style :: Style,
  summaryText :: String
}

type RawFcmOpts = {
  badge :: String,
  style :: String,
  summaryText :: String
}

type RawAlert = {
  title :: String,
  message :: String,
  iOSRegistrationID :: String
}

type Alert = {
  title :: String,
  message :: String,
  iOSRegistrationID :: RegistrationID
}

buildAlert :: Alert -> RawAlert
buildAlert { title, message, iOSRegistrationID } = {
  title, message,
  iOSRegistrationID: show iOSRegistrationID
}

buildFcmOpts :: FcmOpts -> RawFcmOpts
buildFcmOpts { badge, style, summaryText } = {
  badge: show badge,
  style: show style,
  summaryText
}

defaultFcmOpts :: { badge :: Int
 , style :: Style
 , summaryText :: String
 }
defaultFcmOpts = {
  badge: 0,
  style: Inbox,
  summaryText: "Primacy: %n% unread messages"
}
