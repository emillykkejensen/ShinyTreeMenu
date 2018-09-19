#' Render the ShinyTreeMenu HTML
#'
#'
#' Render a reactive ShinyTreeMenu output variable in your Shiny UI.
#'
#'
#' \strong{Width and height:}
#'
#' Besides the normal CSS unit like px, %, vh etc. you can use CSS
#' calculation to controle width and height. For example you can set the
#' height of the menu to the screen height minus 50 px, by setting
#' height = "calc(100vh - 50px)"
#'
#' @param outputId output variable to read the value from
#' @param class character; Additional CSS classes to add to the div output
#' @param width character; A valid CSS unit - default is "200px". See details
#' for advanced options. (like "100\%" or "400px"). If NULL it will adapt to menu.
#' @param height character; A valid CSS unit - default is "100vh". See
#' details for advanced options.
#'
#' @seealso \code{\link{renderShinyTreeMenu}}, \code{\link{updateShinyTreeMenu}}
#' and \code{\link{ShinyTreeMenuHTML}}
#'
#' @inherit renderShinyTreeMenu examples
#'
#' @export
ShinyTreeMenuOutput <- function(outputId, class = NULL, width = "200px", height = "100vh"){

  ns <- NS(outputId)

  style <- c()
  if(!is.null(width)) style <- c(style, paste0("width=", width, ";"))
  if(!is.null(height)) style <- c(style, paste0("max-height=", height, ";"))
  if(length(style)) style <- paste(style, collapse = " ") else NULL

  treeclass <- paste("shiny-html-output shinytreemenu", class)

  ShinyTreeMenuTag <-
    tags$div(id = ns("treemenu"), class = treeclass, style = style,
      div(class = "overlay", style="text-align: center;", tags$i(class = "fa fa-4x fa-refresh fa-spin"))
  )

  htmltools::htmlDependencies(ShinyTreeMenuTag) <-
    htmltools::htmlDependency(name = "font-awesome",
                              version = "4.7.0",
                              src = c(href = "shared/font-awesome"),
                              stylesheet = "css/font-awesome.min.css")

  htmltools::htmlDependencies(ShinyTreeMenuTag) <-
    htmltools::htmlDependency(name = "shinytreemenu",
                              version = "1",
                              src = c(href = "shinytreemenu"),
                              stylesheet = "shinytreemenu.css")

  return(ShinyTreeMenuTag)

}


