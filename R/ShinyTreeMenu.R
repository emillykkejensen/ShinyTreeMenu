#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
ShinyTreeMenu <- function(tree_data, select_id = NULL, level_icons = "plus", elementId = NULL) {

  tree <- treemenu_HTML(tree_data = tree_data,
                        select_id = select_id,
                        level_icons = level_icons)

  # create widget
  htmlwidgets::createWidget(
    name = "ShinyTreeMenu",
    tree,
    package = "ShinyTreeMenu",
    elementId = "treemenu"
  )
}

#' Shiny bindings for ShinyTreeMenu
#'
#' Output and render functions for using ShinyTreeMenu within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a ShinyTreeMenu
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name ShinyTreeMenu-shiny
#'
#' @export
ShinyTreeMenuOutput <- function(outputId){
  htmlwidgets::shinyWidgetOutput(outputId, 'ShinyTreeMenu', width = "auto", height = "auto", package = 'ShinyTreeMenu')
}

#' @rdname ShinyTreeMenu-shiny
#' @export
renderShinyTreeMenu <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, ShinyTreeMenuOutput, env, quoted = TRUE)
}
