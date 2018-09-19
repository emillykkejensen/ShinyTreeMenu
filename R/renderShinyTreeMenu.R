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
#'
#'
#'
#' # Create a reactive expression holding the treedata
#'
#' treedata <- reactive({
#'    ShinyTreeMenu::treetestdata
#' })
#'
#'
#' # Wrap the renderShinyTreeMenu function in a shiny callModule
#'
#' shiny::callModule(ShinyTreeMenu::renderShinyTreeMenu,
#'                   id = "treemenu",
#'                   treedata = treedata,
#'                   level_icons = "tree")
#'
#'
#' # To update your ShinyTreeMenu on selection use:
#'
#' ShinyTreeMenu::updateShinyTreeMenu(
#'   treedata = treedata,
#'   treemenu_open = reactive({input$treemenu_open}),
#'   level_icons = "tree")
#'
#'
#' @export
renderShinyTreeMenu <- function(input, output, session, treedata, level_icons){

  if(!shiny::is.reactive(treedata)) stop("treedata has to be a reactive expression")

  output$treemenu <- renderUI({

    treemenuout <-
      ShinyTreeMenuHTML(
        treedata = treedata(),
        level_icons = level_icons)

  })

}
