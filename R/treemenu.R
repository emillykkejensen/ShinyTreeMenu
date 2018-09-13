#' Build the ShinyTreeMenu HTML
#'
#' treemenu() builds the TreeMenu HTML using treedata
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
treemenu_HTML <- function(tree_data,
                          select_id = NULL,
                          level_icons = c("database", "table", "info")){

  library(data.table)
  library(magrittr)
  library(stringr)

  if(!is.data.table(tree_data)) tree_data <- as.data.table(tree_data)

  if(nrow(tree_data) == 0){

    HTMLout <- "No data available..."

  } else {

    if("rowID" %in% names(tree_data)) tree_data[, rowID := .I]

    levels <- length(grep("level[0-9]+_id", names(tree_data)))

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

      tree_data <- tree_data[eval(parse(text = lookfor))]

      tree_data[, openid := sapply(get(selected_level_id), function(x) paste(c(lookfor_id, x), collapse = "_treehugger_"))]

    } else {

      tree_data[, openid := level1_id]

    }

    if(select_level == levels){

      tree_data <- tree_data[, .(this_id = get(selected_level_id), this_name = get(selected_level_name), rowID, openid)] %>%
        unique(by = c("this_id", "this_name"))

      tree_data[, n_child := 0]

    } else {

      child_level_id <- paste0("level", select_level+1, "_id")

      tree_data <- tree_data[, .(this_id = get(selected_level_id), this_name = get(selected_level_name), child_id = get(child_level_id), rowID, openid)] %>%
        unique(by = c("this_id", "this_name", "child_id"))

      tree_data[, n_child := 1]
      tree_data[is.na(child_id), n_child := 0]

    }

    tree_data <- tree_data[, .(n_child = sum(n_child), rowID = min(rowID)),
                           by = .(this_id, this_name, openid)]

    tree_data[is.na(n_child), n_child := 0]



    # Create a new collum to hold the HTML data
    tree_data[, html_out := NA_character_]

    # If level don't have any childen, then transform them to HTML links
    tree_data[n_child == 0,
              html_out := treemenu_linkBuilder(val = this_id,
                                               level = select_level,
                                               row = rowID,
                                               icon = level_icons[select_level])]

    # If level has childen, then build a new tree for tat level
    tree_data[n_child > 0,
              html_out := treemenu_list(id = this_id,
                                        level = select_level,
                                        row = rowID,
                                        label = this_name,
                                        icon = level_icons[select_level],
                                        openid = openid)]

    # Then collapsing it all to one row (character vector)!
    HTMLout <- paste(tree_data[, html_out], collapse = "", sep = "")


    # If it is level one, then wraps it all in a special ol class
    if(select_level == 1){
      HTMLout <- paste0("<ol class=\"tree\">", HTMLout, "</ol>")
    }

  }

  HTMLout <- HTML(HTMLout)

  return(HTMLout)

}
