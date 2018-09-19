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
#' if (interactive()) {
#'
#'   shinyApp(
#'
#'     ui = fluidPage(
#'
#'       # ShinyTreeMenu uses shinyjs - so remember to include shinyjs in your UI
#'       shinyjs::useShinyjs(),
#'
#'       # As of right now, you manually have to load the shinytreemenu.css file and font-awesome
#'       tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "shinytreemenu/shinytreemenu.css")),
#'       tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "shared/font-awesome/css/font-awesome.min.css")),
#'
#'       ShinyTreeMenuOutput("treemenu")
#'     ),
#'
#'     server = function(input, output, session) {
#'
#'       # Treedata has to be in the form of a reactive expression
#'       treedata <- reactive({
#'         ShinyTreeMenu::treetestdata
#'       })
#'
#'       # Use the shiny callModule to render the ShinyTreeMenu
#'       # Note that you should not include () when adding your reactive treedata
#'       shiny::callModule(ShinyTreeMenu::renderShinyTreeMenu,
#'                         id = "treemenu",
#'                         treedata = treedata,
#'                         level_icons = "tree")
#'
#'       # Here you will update the ShinyTreeMenu
#'       # As with the render function, you should not include () when adding your reactive treedata
#'       ShinyTreeMenu::updateShinyTreeMenu(
#'         treedata = treedata,
#'         treemenu_open = reactive({input$treemenu_open}),
#'         level_icons = "tree")
#'
#'
#'       # For the purpose of displaying the selection functionality
#'       observeEvent(input$treemenu, {
#'         showModal(
#'           modalDialog(
#'             paste("Selected id:", input$treemenu$val,
#'                   "| Selected level:", input$treemenu$level,
#'                   "| Selected row:", input$treemenu$row)
#'           )
#'         )
#'       })
#'
#'
#'     }
#'
#'   )
#'
#' }
#'
#'
#' @export
renderShinyTreeMenu <- function(input, output, session, treedata, level_icons){

  if(!shiny::is.reactive(treedata)) stop("treedata has to be a reactive expression")

  output$treemenu <- shiny::renderUI({

    treemenuout <-
      ShinyTreeMenu::ShinyTreeMenuHTML(
        treedata = treedata(),
        level_icons = level_icons)

  })

}
