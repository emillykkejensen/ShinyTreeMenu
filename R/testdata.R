#' ShinyTreeMenu Test Data
#'
#' A dataset containing four levels of treedata intended show the
#' concept of how ShinyTreeMenu reads treedata.
#'
#' @format A data.table with 45 rows and 8 variables:
#' \describe{
#'   \item{levelX_id}{The id of the branch of that level. Note this must be unique to that branch / level}
#'   \item{levelX_name}{The name of the menu}
#'   ...
#' }
"treetestdata"




# library(data.table)
#
# treetestdata <-
#   data.table::data.table(
#     level1_id = 1:4,
#     level1_name = c("Base 1", "Base 2", "Base 3", "Base 4"))
#
# treetestdata[, level2_id := list(list(NA_character_))]
# treetestdata[, level2_name := list(list(NA_character_))]
#
# treetestdata[1, level2_id := list(list(paste0(level1_id, "-", 1:10)))]
# treetestdata[1, level2_name := list(list(paste("Branch", 1:10)))]
#
# treetestdata[2, level2_id := list(list(paste0(level1_id, "-", 1:5)))]
# treetestdata[2, level2_name := list(list(paste("Branch", 1:5)))]
#
# treetestdata[4, level2_id := list(list(paste0(level1_id, "-", 1:10)))]
# treetestdata[4, level2_name := list(list(paste("Branch", 1:10)))]
#
# treetestdata <-
#   treetestdata[, list(level2_id = unlist(level2_id), level2_name = unlist(level2_name)),
#            by = c("level1_id", "level1_name")]
#
#
# treetestdata[, level3_id := list(list(NA_character_))]
# treetestdata[, level3_name := list(list(NA_character_))]
#
# treetestdata[1, level3_id := list(list(paste0(level2_id, "-", 1:3)))]
# treetestdata[1, level3_name := list(list(paste("Branch", 1:3)))]
# treetestdata[2, level3_id := list(list(paste0(level2_id, "-", 1:3)))]
# treetestdata[2, level3_name := list(list(paste("Branch", 1:3)))]
# treetestdata[3, level3_id := list(list(paste0(level2_id, "-", 1:3)))]
# treetestdata[3, level3_name := list(list(paste("Branch", 1:3)))]
# treetestdata[4, level3_id := list(list(paste0(level2_id, "-", 1:3)))]
# treetestdata[4, level3_name := list(list(paste("Branch", 1:3)))]
# treetestdata[7, level3_id := list(list(paste0(level2_id, "-", 1:10)))]
# treetestdata[7, level3_name := list(list(paste("Branch", 1:10)))]
#
# treetestdata[12, level3_id := list(list(paste0(level2_id, "-", 1:2)))]
# treetestdata[12, level3_name := list(list(paste("Branch", 1:2)))]
# treetestdata[14, level3_id := list(list(paste0(level2_id, "-", 1:7)))]
# treetestdata[14, level3_name := list(list(paste("Branch", 1:7)))]
#
# treetestdata <-
#   treetestdata[, list(level3_id = unlist(level3_id), level3_name = unlist(level3_name)),
#                by = c("level1_id", "level1_name", "level2_id", "level2_name")]
#
#
# treetestdata[, level4_id := list(list(NA_character_))]
# treetestdata[, level4_name := list(list(NA_character_))]
#
# treetestdata[1, level4_id := list(list(paste0(level3_id, "-", 1:6)))]
# treetestdata[1, level4_name := list(list(paste0("Branch", 1:6)))]
#
# treetestdata[3, level4_id := list(list(paste0(level3_id, "-", 1:5)))]
# treetestdata[3, level4_name := list(list(paste0("Branch 1-3-", 1:5)))]
#
# treetestdata[7, level4_id := list(list(paste0(level3_id, "-", 1:2)))]
# treetestdata[7, level4_name := list(list(paste0("Branch 1-7-", 1:2)))]
#
# treetestdata[30, level4_id := list(list(paste0(level3_id, "-", 1:10)))]
# treetestdata[30, level4_name := list(list(paste0("Branch 2-4-", 1:10)))]
#
#
# treetestdata <-
#   treetestdata[, list(level4_id = unlist(level4_id), level4_name = unlist(level4_name)),
#            by = c("level1_id", "level1_name", "level2_id", "level2_name", "level3_id", "level3_name")]
#
# devtools::use_data(treetestdata, overwrite = TRUE)
#
