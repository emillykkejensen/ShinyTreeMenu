#' Render the ShinyTreeMenu HTML
#'
#' Render a reactive ShinyTreeMenu output variable in your Shiny UI.
#'
#' @param outputId output variable to read the value from
#' @param class character; Additional CSS classes to add to the div output
#'
#' @examples
#'
#' ShinyTreeMenuOutput("treemenu")
#'
#' @export
ShinyTreeMenuOutput <- function(outputId, class = NULL){

  ns <- NS(outputId)

  treeclass <- paste("shiny-html-output shinytreemenu", class)

  div(id = ns("treemenu"), class = treeclass,
      div(class = "overlay", style="text-align: center;", tags$i(class = "fa fa-4x fa-refresh fa-spin"))
  )

}


