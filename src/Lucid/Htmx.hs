module Lucid.Htmx where

import Data.Text (Text)
import Lucid.Base

{- Core Attributes -}

-- | <https://htmx.org/attributes/hx-get/>
hxGet_ :: Text -> Attribute
hxGet_ = makeAttribute "hx-get"

-- | <https://htmx.org/attributes/hx-post/>
hxPost_ :: Text -> Attribute
hxPost_ = makeAttribute "hx-post"

-- | <https://htmx.org/attributes/hx-on/>
hxOn_ :: Text -> Attribute
hxOn_ = makeAttribute "hx-on"

-- | <https://htmx.org/attributes/hx-push-url/>
hxPushUrl_ :: Text -> Attribute
hxPushUrl_ = makeAttribute "hx-push-url"

-- | <https://htmx.org/attributes/hx-select/>
hxSelect_ :: Text -> Attribute
hxSelect_ = makeAttribute "hx-select"

-- | <https://htmx.org/attributes/hx-select/>
hxSelectOob_ :: Text -> Attribute
hxSelectOob_ = makeAttribute "hx-select-oob"

-- | <https://htmx.org/attributes/hx-swap/>
hxSwap_ :: Text -> Attribute
hxSwap_ = makeAttribute "hx-swap"

-- | <https://htmx.org/attributes/hx-swap-oob/>
hxSwapOob_ :: Text -> Attribute
hxSwapOob_ = makeAttribute "hx-swap-oob"

-- | <https://htmx.org/attributes/hx-target/>
hxTarget_ :: Text -> Attribute
hxTarget_ = makeAttribute "hx-target"

-- | <https://htmx.org/attributes/hx-trigger/>
hxTrigger_ :: Text -> Attribute
hxTrigger_ = makeAttribute "hx-trigger"

-- | <https://htmx.org/attributes/hx-vals/>
hxVals_ :: Text -> Attribute
hxVals_ = makeAttribute "hx-vals"

{- Core Attributes -}
