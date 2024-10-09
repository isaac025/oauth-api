{-# LANGUAGE RecordWildCards #-}

module Server where

import App
import Configuration
import Control.Monad.Reader (asks)
import Data.Text (Text)
import Lucid (Html)
import Network.Wai
import Network.Wai.Handler.Warp
import Pages
import Servant
import Servant.HTML.Lucid (HTML)

type API =
    "login" :> Get '[HTML] (Html ())
        :<|> "callback" :> QueryParam "code" Text :> Get '[JSON] Token

loginHandler :: OAuth (Html ())
loginHandler = do
    OAuthConfig{..} <- asks oauthConfig
    let googleAuthURL = oauthUrl <> "?response_type=code" <> "&client_id=" <> clientId <> "&redirect_uri=" <> redirectUri <> "&scope=openid%20email"
    pure $ loginButton googleAuthURL

callbackHandler :: Maybe Text -> OAuth Token
callbackHandler = pure . Token

server :: ServerT API OAuth
server = loginHandler :<|> callbackHandler

api :: Proxy API
api = Proxy

app :: Config -> Application
app config = serve (Proxy :: Proxy API) (hoistServer (Proxy :: Proxy API) (runOAuth config) server)

runApp :: IO ()
runApp = do
    cfg <- loadConfig
    run 8080 (app cfg)
