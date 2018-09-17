#' Render the ShinyTreeMenu HTML
#'
#' This function should be run within the Shiny \code{\link[shiny]{callModule}}
#' function and renders a reactive ShinyTreeMenu HTML.
#'
#' renderShinyTreeMenu is a dynamic HTML rendering function, that
#' runs within the Shiny \code{\link[shiny]{callModule}} function.
#'
#' renderShinyTreeMenu renders the initial treemenu as a reactive
#' Shiny UI Output and this treemenu can then be updated using
#' \code{\link{updateShinyTreeMenu}}.
#'
#' @param treedata data.table; treedata - see \code{\link{ShinyTreeMenuHTML}} for more details.
#' @param level_icons character; Names of fa-icons to use for the tree - see \code{\link{ShinyTreeMenuHTML}} for more details.
#'
#' @seealso \code{\link{ShinyTreeMenuOutput}}, \code{\link{updateShinyTreeMenu}} and \code{\link{ShinyTreeMenuHTML}}
#'
#' @examples
#'
#' # Create a reactive expression holding the treedata
#'
#' treedata <- reactive({
#'    treedata <-
#'      data.table::data.table(
#'        level1_id = 1:4,
#'        level1_name = c("Base 1", "Base 2", "Base 3", "Base 4"),
#'        level2_id = list(1:10,
#'                         1:5,
#'                         1:5,
#'                         1:10),
#'        level2_name = list(paste("Branch 1 no", 1:10),
#'                           paste("Branch 2 no", 1:5),
#'                           paste("Branch 3 no", 1:5),
#'                           paste("Branch 4 no", 1:10)))
#'
#'
#'    treedata <-
#'      treedata[, list(level2_id = unlist(level2_id), level2_name = unlist(level2_name)),
#'               by = c("level1_id", "level1_name")]
#'
#'    return(treedata
#'
#' })
#'
#'
#' # Wrap the renderShinyTreeMenu function in a shiny callModule
#'
#' shiny::callModule(ShinyTreeMenu::renderShinyTreeMenu,
#'                   id = "treemenu",
#'                   treedata = treedata,
#'                   level_icons = c("tree", "pagelines"))
#'
#'
#' # To update your ShinyTreeMenu on selection use:
#'
#' ShinyTreeMenu::updateShinyTreeMenu(
#'   treedata = treedata,
#'   treemenu_open = reactive({input$treemenu_open}),
#'   level_icons = c("tree", "pagelines"))
#'
#'
#' @export
renderShinyTreeMenu <- function(input, output, session, treedata, level_icons){

  output$treemenu <- renderUI({

    treemenuout <-
      ShinyTreeMenuHTML(
        tree_data = treedata(),
        level_icons = level_icons)

  })

}
