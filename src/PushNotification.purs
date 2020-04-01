module PushNotification (
  Bundle(..), Title, Body, BadgeCount,
  sendNotification
) where

import Prelude

import Effect (Effect)
import Foreign.Generic.Class (class Encode)
import PushNotification.Apn as Apn
import PushNotification.Fcm as Fcm
import PushNotification.RegistrationId (AndroidRegistrationId, ApnDeviceToken)

type Title = String
type Body = String
type BadgeCount = Int

data Bundle =
    Apn Apn.Provider ApnDeviceToken
  | Fcm Fcm.Provider AndroidRegistrationId

-- Right now default options are always used for both. Obviously this would be
-- pretty easy to change, but I don't have a reason to change it atm.
sendNotification :: ∀ a. Encode a => Bundle -> Title -> Body -> a -> BadgeCount -> Effect Unit
sendNotification (Apn p dT) title body payload badgeCount =
  Apn.unsafeSendNotification p dT title body payload badgeCount Apn.defaultOpts
sendNotification (Fcm p aRId) title body payload badgeCount =
  Fcm.unsafeSendNotification p aRId title body payload badgeCount Fcm.defaultOpts
