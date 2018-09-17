#' Update the ShinyTreeMenu
#'
#' updateShinyTreeMenu() updates the tree menu, when a new level is selected
#'
#' @param treedata data.table; treedata - see details for more
#' @param treemenu_open reactive expression; Id belonging to the branch you want to open.
#' @param level_icons character; Names of fa-icons to use for the tree - see [ShinyTreeMenuHTML()] for more details.
#'
#' @return A HTML class character containing the tree menu
#'
#' @seealso \code{\link{renderShinyTreeMenu}} and \code{\link{ShinyTreeMenuHTML}}
#'
#' @inherit renderShinyTreeMenu examples
#'
#' @export
updateShinyTreeMenu <- function(treedata, treemenu_open, level_icons){
  observeEvent(treemenu_open(), {
    shinyjs::html(id = paste0("treemenu_open_", treemenu_open()$openid),
                  html =
                    treemenu_HTML(
                      tree_data = treedata(),
                      select_id = treemenu_open()$openid,
                      level_icons = level_icons))
  })
}
