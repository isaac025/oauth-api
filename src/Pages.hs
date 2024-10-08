module Pages where

import Clay (Css)
import Data.Text (Text)
import Lucid
import Lucid.Base (makeAttribute, makeElement)

-- import Lucid.Htmx (hxBoost_, hxTrigger_)
import PagesCss

cssToHtml :: [Css] -> Html ()
cssToHtml css = style_ [type_ "text/css"] (foldMap renderCss css)

oauthBase :: Html () -> Html ()
oauthBase h = do
    doctypehtml_ $ do
        html_ $ do
            head_ $ do
                title_ "OAuth2"
                cssToHtml cssList
                script_ [src_ "https://unpkg.com/htmx.org@2.0.3", integrity_ "sha384-0895/pl2MU10Hqc6jd4RvrthNlDiE9U1tWmX7WRESftEDRosgxNsQG/Ze9YMRzHq", crossorigin_ "anonymous"] ("" :: Text)
            body_ $ do
                h

loginButton :: Text -> Html ()
loginButton oauthurl = oauthBase $ do
    a_ [href_ oauthurl] $ do
        button_ [class_ "gsi-material-button", type_ "submit"] $ do
            div_ [class_ "gsi-material-button-state"] ""
            div_ [class_ "gsi-material-button-content-wrapper"] $ do
                div_ [class_ "gsi-material-button-icon"] $ do
                    googleSvg_
                span_ [class_ "gsi-material-button-contents"] "Sign in with Google"
                span_ [style_ "display: none;"] "Sign in with Google"
  where
    googleSvg_ :: Html ()
    googleSvg_ =
        svg_ [version_ "1.1", xmlns_ "http://www.w3.org/2000/svg", viewBox_ "0 0 48 48", xmlnsXlink_ "http://www.w3.org/1999/xlink", style_ "display: block;"] $ do
            path_ [fill_ "#EA4335", d_ "M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"] ""
            path_ [fill_ "#4285F4", d_ "M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"] ""
            path_ [fill_ "#FBBC05", d_ "M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"] ""
            path_ [fill_ "#34A853", d_ "M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.15 1.45-4.92 2.3-8.16 2.3-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"] ""
            path_ [fill_ "none", d_ "M0 0h48v48H0z"] ""
    version_ = term "version"
    viewBox_ = makeAttribute "viewBox"
    xmlnsXlink_ = makeAttribute "xmlns:xlink"
    path_ = with (makeElement "path")
    fill_ = makeAttribute "fill"
    d_ = makeAttribute "d"
