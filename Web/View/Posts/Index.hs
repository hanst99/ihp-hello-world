module Web.View.Posts.Index where
import Web.View.Prelude

data IndexView = IndexView { posts :: [ Post ]  }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {breadcrumb}

        <h1>Index<a href={pathTo NewPostAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <ul>
                {forEach posts renderPost}
            </ul> 
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Posts" PostsAction
                ]

renderPost :: Post -> Html
renderPost post = [hsx|
    <li style="display: flex">
        <a href={ShowPostAction (get #id post)}>{get #title post}</a>
        <a style="margin-left: 10px" href={EditPostAction (get #id post)} class="text-muted">Edit</a>
        <a style="margin-left: 10px" href={DeletePostAction (get #id post)} class="js-delete text-muted">Delete</a>
    </li>
|]
