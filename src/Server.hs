{-# LANGUAGE RecordWildCards #-}

module Server where

import App
import Configuration
import Control.Monad.Reader (asks)
import Lucid (Html, a_, h1_, href_, p_)
import Network.Wai
import Network.Wai.Handler.Warp
import Pages
import Servant
import Servant.HTML.Lucid (HTML)

type API = "login" :> Get '[HTML] (Html ())

loginHandler :: OAuth (Html ())
loginHandler = do
    OAuthConfig{..} <- asks oauthConfig
    let googleAuthURL = oauthUrl <> "?client_id=" <> clientId <> "&redirect_uri=" <> redirectUri <> "&response_type=code" <> "&scope=openid%20email"
    pure $
        base $ do
            h1_ "Login"
            p_ "Click the link to log in via Google:"
            a_ [href_ googleAuthURL] "Login with Google"

server :: ServerT API OAuth
server = loginHandler

api :: Proxy API
api = Proxy

app :: Config -> Application
app config = serve (Proxy :: Proxy API) (hoistServer (Proxy :: Proxy API) (runOAuth config) server)

runApp :: IO ()
runApp = do
    cfg <- loadConfig
    run 8080 (app cfg)
