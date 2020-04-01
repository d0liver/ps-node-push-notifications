module PushNotification.Id (
  AndroidRegistrationId(..), ApnDeviceToken(..)
) where

import Prelude

import Data.Generic.Rep (class Generic)
import Foreign.Generic (genericDecode, genericEncode)
import Foreign.Generic.Class (class Decode, class Encode, defaultOptions)

newtype AndroidRegistrationId = AndroidRegistrationId String
newtype ApnDeviceToken = ApnDeviceToken String

derive instance genericAndroidRegistrationId :: Generic AndroidRegistrationId _
instance encodeAndroidRegistrationId :: Encode AndroidRegistrationId where
  encode = genericEncode $ defaultOptions { unwrapSingleConstructors = true }
instance decodeAndroidRegistrationId :: Decode AndroidRegistrationId where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }

derive instance genericApnDeviceToken :: Generic ApnDeviceToken _
instance encodeApnDeviceToken :: Encode ApnDeviceToken where
  encode = genericEncode $ defaultOptions { unwrapSingleConstructors = true }
instance decodeApnDeviceToken :: Decode ApnDeviceToken where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }
