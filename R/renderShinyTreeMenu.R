#' Render the ShinyTreeMenu HTML
#'
#' @examples
#'
#' renderShinyTreeMenu(
#'    treedata = treedata,
#'    treemenu_open = reactive({input$treemenu_open}),
#'    level_icons = "plus")
#'
#'
#' @export
renderShinyTreeMenu <- function(input, output, session, treedata, level_icons){

  output$treemenu <- renderUI({

    treemenuout <-
      treemenu_HTML(
        tree_data = treedata(),
        level_icons = level_icons)

  })

}
