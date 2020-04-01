module PushNotification.Apn (
  Provider, ProviderConfig, Opts, Sound,
  initProvider, defaultOpts, unsafeSendNotification
) where

import Prelude

import Control.Monad.Error.Class (throwError)
import Data.List.NonEmpty as NL
import Effect (Effect)
import Foreign (Foreign, ForeignError(..), readString)
import Foreign.Generic.Class (class Decode, class Encode, encode)
import Moment (Duration, Increment(..), duration)
import Node.Path (FilePath)
import PushNotification.RegistrationId (ApnDeviceToken)

-- TODO: This actually hands back a promise, but I don't particularly care about
-- the result right now.
foreign import data Provider :: Type
foreign import _sendApnNotification :: Provider -> Foreign -> String -> String -> Foreign -> Int -> Foreign -> Effect Unit
foreign import initProvider :: Foreign -> Effect Provider

type ProviderConfig = {
  token :: {
    key :: FilePath,
    keyId :: String,
    teamId :: String
  },
  -- Stupidly required by APN on each PN for some reason. I've bundled this up
  -- with the provider so that I don't have to specify the app id with each
  -- call.
  appId :: String,
  production :: Boolean
}

unsafeSendNotification :: ∀ a. Encode a => Provider -> ApnDeviceToken -> String -> String -> a -> Int -> Opts -> Effect Unit
unsafeSendNotification provider dT title body payload badgeCount opts =
  _sendApnNotification provider (encode dT) title body (encode payload) badgeCount (encode opts)

data Sound = Ping

instance encodeSound :: Encode Sound where
  encode Ping = encode "ping.aiff"

instance decodeSound :: Decode Sound where
  decode f = do
    s <- readString f
    case s of
      "ping.aiff" -> pure Ping
      _ -> throwError (NL.singleton $ ForeignError ("Invalid Sound: '"<> s <> "'"))

type Opts = {
  expiry :: Duration,
  sound :: Sound
}

defaultOpts :: Opts
defaultOpts = {
  expiry: duration 1 Hours,
  sound: Ping
}
