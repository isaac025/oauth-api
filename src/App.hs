module App where

import Configuration
import Control.Monad.Reader
import Data.Monoid (Ap (..))
import Servant (Handler)

{- newtype Token = Token (Maybe Text)
newtype OAuth a = OAuth (ReaderT Config (StateT Token Handler) a)
-}

-- | Our OAuth monad
newtype OAuth a = OAuth (ReaderT Config Handler a)
    deriving (Functor, Applicative, Monad, MonadIO, MonadReader Config)
    deriving (Semigroup, Monoid) via Ap OAuth a

runOAuth :: Config -> OAuth a -> Handler a
runOAuth c (OAuth a) = runReaderT a c
