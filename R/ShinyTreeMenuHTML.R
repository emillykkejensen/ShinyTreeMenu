#' Build the ShinyTreeMenu HTML
#'
#'
#' ShinyTreeMenuHTML() builds the TreeMenu HTML using treedata. You can render the
#' TreeMenu HTML using \code{\link{renderShinyTreeMenu}}
#'
#'
#' \strong{treedata:}
#'
#' The data used by ShinyTreeMenu is a long formatet data.table considing
#' of two colums for every level in the tree. Thees two colums must be named:
#' \itemize{
#'        \item levelX_id: The id used to identify the item. This must be unique within the same branch.
#'        \item levelX_name: The name to be shown in the menu.
#' }
#' X = the level number
#'
#' For further explanation, see examples.
#'
#' @param treedata data.table; treedata - see details for more
#' @param select_id character; Id belonging to the branch you want to open.
#' If NULL (default) the function will return the base tree using level 1.
#' @param level_icons character; Names of fa-icons to use for the tree.
#' Must be of length 1 or the same length as the number of levels.
#'
#' @return A HTML class character containing the tree menu. If select_id is
#' NULL it will return the base base tree HTML using level 1. Otherwise it
#' will return the branch of select_id.
#'
#' @examples
#'
#' # Use test data from ShinyTreeMenu
#  treedata <- ShinyTreeMenu::treetestdata
#'
#'
#' #######################################
#' #--- Example to understand the concept
#'
#' # Generate base tree HTML at level 1
#' treemenu <-
#'    ShinyTreeMenuHTML(treedata = treedata,
#'                      level_icons = c("tree", "pagelines"))
#'
#'
#' # Generate branch HTML to level 1, id 3
#' branch_3 <-
#'    ShinyTreeMenuHTML(treedata = treedata,
#'                      select_id = "3",
#'                      level_icons = c("tree", "pagelines"))
#'
#'
#' #######################################
#' #--- Shiny example
#'
#' # To use ShinyTreeMenuHTML() with RStudio Shiny use renderShinyTreeMenu()
#'
#' @export
ShinyTreeMenuHTML <- function(treedata, select_id = NULL, level_icons = "plus"){

  library(data.table)
  library(magrittr)
  library(stringr)

  if(!is.data.table(treedata)) treedata <- as.data.table(treedata)

  if(nrow(treedata) == 0){

    HTMLout <- "No data available..."

  } else {

    if(!("rowID" %in% names(treedata))) treedata[, rowID := .I]

    levels <- length(grep("level[0-9]+_id", names(treedata)))

    if(length(level_icons) == 1 & levels != 1) level_icons <- rep(level_icons, levels)
    if(length(level_icons) != levels) stop("level_icons must be of length 1 or the same length as the number of levels.")

    if(is.null(select_id)){
      select_level <- 1
    } else {
      select_level <- stringr::str_count(select_id, "\\_treehugger_") + 2
    }

    selected_level_id <- paste0("level", select_level, "_id")
    selected_level_name <- paste0("level", select_level, "_name")

    if(select_level > 1){

      lookfor_id <- strsplit(select_id, "_treehugger_", fixed = T)[[1]]
      lookfor_idname <- paste0("level", 1:(select_level-1), "_id")

      lookfor <- paste(paste0(lookfor_idname, " == '", lookfor_id, "'"), collapse = " & ")

      treedata <- treedata[eval(parse(text = lookfor))]

      treedata[, openid := sapply(get(selected_level_id), function(x) paste(c(lookfor_id, x), collapse = "_treehugger_"))]

    } else {

      treedata[, openid := level1_id]

    }

    if(select_level == levels){

      treedata <- treedata[, .(this_id = get(selected_level_id), this_name = get(selected_level_name), rowID, openid)] %>%
        unique(by = c("this_id", "this_name"))

      treedata[, n_child := 0]

    } else {

      child_level_id <- paste0("level", select_level+1, "_id")

      treedata <- treedata[, .(this_id = get(selected_level_id), this_name = get(selected_level_name), child_id = get(child_level_id), rowID, openid)] %>%
        unique(by = c("this_id", "this_name", "child_id"))

      treedata[, n_child := 1]
      treedata[is.na(child_id), n_child := 0]

    }

    treedata <- treedata[, .(n_child = sum(n_child), rowID = min(rowID)),
                         by = .(this_id, this_name, openid)]

    treedata[is.na(n_child), n_child := 0]



    # Create a new collum to hold the HTML data
    treedata[, html_out := NA_character_]

    # If level don't have any childen, then transform them to HTML links
    treedata[n_child == 0,
             html_out := treemenu_linkBuilder(val = this_id,
                                              level = select_level,
                                              row = rowID,
                                              icon = level_icons[select_level])]

    # If level has childen, then build a new tree for tat level
    treedata[n_child > 0,
             html_out := treemenu_list(id = this_id,
                                       level = select_level,
                                       row = rowID,
                                       label = this_name,
                                       icon = level_icons[select_level],
                                       openid = openid)]

    # Then collapsing it all to one row (character vector)!
    HTMLout <- paste(treedata[, html_out], collapse = "", sep = "")


    # If it is level one, then wraps it all in a special ol class
    if(select_level == 1){
      HTMLout <- paste0("<ol class=\"tree\">", HTMLout, "</ol>")
    }

  }

  HTMLout <- HTML(HTMLout)

  return(HTMLout)

}
