#' Render the ShinyTreeMenu HTML
#'
#' treemenu() renders the TreeMenu HTML using treedata
#'
#'
#'
#' @param tree_data data.table; treedata - see details for more
#' @param select_id character; Id belonging to the branch you want to open.
#' If NULL (default) the function will return the base tree using level 1.
#' @param level_icons character; Names of fa-icons to use for the tree.
#' Must be of length 1 or the same length as the number of levels.
#'
#' @return A HTML class character containing the tree menu
#'
#' @examples
#'
#' @export
ShinyTreeMenuOutput <- function(id, class = NULL) {

  ns <- NS(id)

  treeclass <- paste("shiny-html-output shinytreemenu", class)

  div(id = ns("treemenu"), class = treeclass,
      div(class = "overlay", style="text-align: center;", tags$i(class = "fa fa-4x fa-refresh fa-spin"))
  )

}


