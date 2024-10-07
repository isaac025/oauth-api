module PagesCss (
    renderCss,
    cssList,
) where

import Clay
import Clay.Flexbox qualified as F
import Clay.Selector (selectorFromText)
import Clay.Text qualified as T
import Data.List.NonEmpty (fromList)
import Data.Text (Text)
import Data.Text.Lazy (toStrict)
import Prelude hiding (not)

renderCss :: Css -> Text
renderCss = toStrict . render

cssList :: [Css]
cssList =
    [ gsiMaterialButton
    , gsiMaterialButtonActive
    , gsiMaterialButtonContentWrapper
    , gsiMaterialButtonContents
    , gsiMaterialButtonIcon
    , gsiMaterialButtonHover
    ]

gsiMaterialButton :: Css
gsiMaterialButton =
    ".gsi-material-button" ? do
        userSelect none
        backgroundColor white
        border (px 1) solid "#747775"
        borderRadius (px 4) (px 4) (px 4) (px 4)
        boxSizing borderBox
        color "#1f1f1f"
        fontFamily ["Roboto", "arial", "sans-serif"] []
        fontSize (px 14)
        height (px 40)
        letterSpacing (px 0.25)
        outline none (px 0) transparent
        overflow hidden
        padding (px 0) (px 12) (px 0) (px 12)
        textAlign center
        transitions
            [ ("background-color", sec 0.218, ease, sec 0.218)
            , ("border-color", sec 0.218, ease, sec 0.218)
            , ("box-shadow", sec 0.218, ease, sec 0.218)
            ]
        verticalAlign middle
        whiteSpace T.nowrap
        width auto
        maxWidth (px 400)
        minWidth minContent

makeSelector :: Css -> Selector
makeSelector = selectorFromText . renderCss

gsiMaterialButtonIcon :: Css
gsiMaterialButtonIcon =
    makeSelector gsiMaterialButton ? do
        ".gsi-material-button-icon" ? do
            height (px 20)
            marginRight (px 12)
            minWidth (px 20)
            width (px 20)

gsiMaterialButtonContentWrapper :: Css
gsiMaterialButtonContentWrapper =
    makeSelector gsiMaterialButton ? do
        ".gsi-material-button-content-wrapper" ? do
            alignItems center
            display flex
            flexDirection row
            flexWrap F.nowrap
            height (pct 100)
            justifyContent spaceBetween
            width (pct 100)

gsiMaterialButtonContents :: Css
gsiMaterialButtonContents =
    makeSelector gsiMaterialButton ? do
        ".gsi-material-button-contents" ? do
            flexGrow 1
            fontFamily ["Roboto", "arial", "sans-serif"] [sansSerif]
            fontWeight (weight 500)
            overflow hidden
            textOverflow overflowEllipsis
            verticalAlign vAlignTop

gsiMaterialButtonState :: Css
gsiMaterialButtonState =
    makeSelector gsiMaterialButton ? do
        ".gsi-material-button-state" ? do
            transition "opacity" (sec 0.218) ease (sec 0.218)
            position absolute
            top (px 0)
            right (px 0)
            bottom (px 0)
            left (px 0)
            opacity 0

gsiMaterialButtonActive :: Css
gsiMaterialButtonActive =
    makeSelector gsiMaterialButton ? do
        backgroundColor "#303030"
        opacity 0.12

-- .gsi-material-button:not(:disabled):hover {
gsiMaterialButtonHover :: Css
gsiMaterialButtonHover =
    let bs1 = bsColor (rgba 60 64 67 0.3) $ shadowWithBlur (px 0) (px 1) (px 2)
        bs2 = bsColor (rgba 60 64 67 0.15) $ shadowWithBlur (px 0) (px 1) (px 3)
        but = makeSelector gsiMaterialButton
     in but # disabled # hover ? do
            boxShadow $ fromList [bs1, bs2]
