#' @import shiny
.onLoad <- function(...){

  shiny::addResourcePath("shinytreemenu", system.file("www", package = "ShinyTreeMenu"))

}


# htmltools::htmlDependency(
#   name = "ShinyTreeMenu", version = "0.1",
#   package = "ShinyTreeMenu",
#   src = "shinytreemenu",
#   stylesheet = "css/shinytreemenu.css"
# )
#
# createWebDependency("shinytreemenu")
