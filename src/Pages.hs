module Pages where

import Lucid

base :: Html () -> Html ()
base html = do
    doctypehtml_ $ do
        head_ $ do
            title_ "OAuth2"
            script_ [src_ "https://unpkg.com/htmx.org@2.0.3", integrity_ "sha384-0895/pl2MU10Hqc6jd4RvrthNlDiE9U1tWmX7WRESftEDRosgxNsQG/Ze9YMRzHq", crossorigin_ "anonymous"] ("" :: String)
        body_ $ do
            html
