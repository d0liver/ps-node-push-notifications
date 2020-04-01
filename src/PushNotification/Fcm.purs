module PushNotification.Fcm (
  Provider, Opts, Style, ProviderConfig,
  initProvider, defaultOpts,
  unsafeSendNotification
) where

import Prelude

import Data.Generic.Rep (class Generic)
import Effect (Effect)
import Foreign (Foreign)
import Foreign.Generic (genericEncode, genericDecode)
import Foreign.Generic.Class (class Decode, class Encode, defaultOptions, encode)
import Node.Path (FilePath)
import PushNotification.RegistrationId (AndroidRegistrationId)

foreign import data Provider :: Type
foreign import _sendFcmNotification :: Provider -> Foreign -> String -> String -> Foreign -> Int -> Foreign -> Effect Unit
foreign import initProvider :: ProviderConfig -> Effect Provider

data Fcm = Fcm Provider AndroidRegistrationId

type ProviderConfig = {
  keyFilePath :: FilePath
}

unsafeSendNotification :: ∀ a. Encode a => Provider -> AndroidRegistrationId -> String -> String -> a -> Int -> Opts -> Effect Unit
unsafeSendNotification provider aRId title body payload badgeCount opts =
  _sendFcmNotification provider (encode aRId) title body (encode payload) badgeCount (encode opts)

data Style = Inbox

derive instance genericStyle :: Generic Style _
instance encodeStyle :: Encode Style where
  encode = genericEncode $ defaultOptions
instance decodeStyle :: Decode Style where
  decode = genericDecode $ defaultOptions

type Opts = {
  style :: Style,
  summaryText :: String
}

defaultOpts :: Opts
defaultOpts = {
  style: Inbox,
  summaryText: "New unread messages"
}
