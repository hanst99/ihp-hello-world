module Web.View.Posts.Show where
import Web.View.Prelude
import qualified Text.MMark as MMark
-- import Text.Blaze.Html4.Strict (preEscapedToHtml)

data ShowView = ShowView { post :: Post }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1> {get #title post} </h1>
        <p> {get #createdAt post |> timeAgo } </p>
        <p> {get #body post |> renderMarkdown} </p>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Posts" PostsAction
                            , breadcrumbText "Show Post"
                            ]

renderMarkdown text = case text |> MMark.parse "" of
    Left error -> toHtml $ "Invalid markdown (" ++ show error ++ ")"
    Right markdown -> MMark.render markdown |> tshow |> preEscapedToHtml
