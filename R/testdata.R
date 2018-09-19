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
#     level1_name = c("Base 1", "Base 2", "Base 3", "Base 4"),
#     level2_id = list(1:10,
#                      1:5,
#                      NA_integer_,
#                      1:10),
#     level2_name = list(paste("Branch", 1:10),
#                        paste("Branch", 1:5),
#                        NA_character_,
#                        paste("Branch", 1:10)))
#
# treetestdata <-
#   treetestdata[, list(level2_id = unlist(level2_id), level2_name = unlist(level2_name)),
#            by = c("level1_id", "level1_name")]
#
#
# treetestdata[, level3_id := NA_integer_]
# treetestdata[, level3_name := NA_character_]
#
# treetestdata[1:10, level3_id := 1:10]
# treetestdata[1:10, level3_name := paste0("Branch 1-", 1:10)]
#
# treetestdata[c(12,14), level3_id := 1:2]
# treetestdata[c(12,14), level3_name := c("Branch 2-2", "Branch 2-4")]
#
#
# treetestdata[, level4_id := list(list(NA_integer_))]
# treetestdata[, level4_name := list(list(NA_character_))]
#
# treetestdata[1, level4_id := list(list(1:6))]
# treetestdata[1, level4_name := list(list(paste0("Branch 1-1-", 1:6)))]
#
# treetestdata[3, level4_id := list(list(1:5))]
# treetestdata[3, level4_name := list(list(paste0("Branch 1-3-", 1:5)))]
#
# treetestdata[7, level4_id := list(list(1:2))]
# treetestdata[7, level4_name := list(list(paste0("Branch 1-7-", 1:2)))]
#
# treetestdata[14, level4_id := list(list(1:10))]
# treetestdata[14, level4_name := list(list(paste0("Branch 2-4-", 1:10)))]
#
#
# treetestdata <-
#   treetestdata[, list(level4_id = unlist(level4_id), level4_name = unlist(level4_name)),
#            by = c("level1_id", "level1_name", "level2_id", "level2_name", "level3_id", "level3_name")]
#
# save(treetestdata, file = "data/testdata.Rdata")
