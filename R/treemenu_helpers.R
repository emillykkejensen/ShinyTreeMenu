treemenu_setInputTreeValue <- function(val, level, row){
  if(length(val) == 1){
    return(paste0("javascript:Shiny.setInputValue('treemenu', {val:'", val, "', level:", level, ", row:", row, "});"))
  } else {
    return(sapply(seq(val), function(x) treemenu_setInputTreeValue(val[x], level, row[x])))
  }
}

treemenu_linkBuilder <- function(val, level, row, label, icon){
  if(length(val) == 1){
    return(paste0("
  <li class=\"level", level, "\">
    <a href=\"", treemenu_setInputTreeValue(val, level, row), "\">
      <i class=\"fa fa-", icon, "\" aria-hidden=\"true\"></i> ", label, "
    </a>
  </li>"))
  } else {
    return(sapply(seq(val), function(x) treemenu_linkBuilder(val[x], level, row[x], label[x], icon)))
  }
}

treemenu_list <- function(id, level, row, label, icon, openid){

  paste0("<li class=\"level", level, "\">
            <label for=\"", id, "\"></label>",
            "<a href=\"", treemenu_setInputTreeValue(id, level, row), "\">",
              "<i class=\"fa fa-", icon, "\" aria-hidden=\"true\"></i> ", label,
            "</a>
            <input type=\"checkbox\" id=\"", id, "\" onclick=\"javascript:Shiny.setInputValue('treemenu_open', {openid:'", openid, "', randomVal:Math.random()});\"/>
            <ol id=\"treemenu_open_", openid, "\">
              <li class=\"loading\">
                <i class=\"fa fa-circle-o-notch fa-spin fa-fw\"></i>
              </li>
            </ol>
          </li>")

}
