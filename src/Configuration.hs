{-# LANGUAGE DeriveGeneric #-}

module Configuration where

import Control.Monad.IO.Class
import Data.Aeson (FromJSON (..), withObject, (.:))
import Data.Text (Text)
import Data.Yaml (decodeFileEither)
import GHC.Generics (Generic)
import System.Directory
import System.Environment (lookupEnv)

data Environment
    = Dev
    | Test
    | Prod
    deriving (Show)

deriving instance Read Environment

data OAuthConfig = OAuthConfig
    { oauthUrl :: Text
    , clientId :: Text
    , clientSecret :: Text
    , redirectUri :: Text
    }
    deriving (Show, Generic)

instance FromJSON OAuthConfig where
    parseJSON = withObject "OAuthConfig" $ \v ->
        OAuthConfig
            <$> v .: "oauthUrl"
            <*> v .: "clientId"
            <*> v .: "clientSecret"
            <*> v .: "redirectUri"

data Config = Config
    { oauthConfig :: OAuthConfig
    , environment :: Environment
    }
    deriving (Show)

loadConfig :: (Monad m, MonadIO m) => m Config
loadConfig = do
    envVar <- liftIO $ lookupEnv "APP_ENV"
    (oauth, env) <- makeOAuthConfig (maybe Dev read envVar)
    pure (Config oauth env)

makeOAuthConfig :: (Monad m, MonadIO m) => Environment -> m (OAuthConfig, Environment)
makeOAuthConfig Dev = do
    l <- elem "./.env.yml" <$> liftIO (getDirectoryContents =<< getCurrentDirectory)
    if l
        then error "configuration file does not exists"
        else do
            mcfile <- liftIO $ decodeFileEither ".env.yml"
            case mcfile of
                Left err -> error $ "Parsing config file failed: " ++ show err
                Right oauth -> pure (oauth, Dev)
makeOAuthConfig Test = undefined
makeOAuthConfig Prod = undefined
