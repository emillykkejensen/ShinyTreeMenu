<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis-CI Build Status](https://travis-ci.org/emillykkejensen/ShinyTreeMenu.svg?branch=master)](https://travis-ci.org/emillykkejensen/ShinyTreeMenu)

ShinyTreeMenu
=============

ShinyTreeMenu provides a clean tree menu UI useing only HTML and CSS, with lazy loading making it posible to build enormous tree menus.

Installation
------------

You can install ShinyTreeMenu from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("emillykkejensen/ShinyTreeMenu")
```

Example
=======

To try out ShinyTreeMenu, you can run the following example:

``` r
library(ShinyTreeMenu)

shinyApp(

  ui = fluidPage(

    # ShinyTreeMenu uses shinyjs - so remember to include shinyjs in your UI
    shinyjs::useShinyjs(),

    ShinyTreeMenuOutput("treemenu")
  ),

  server = function(input, output, session) {

    # Treedata has to be in the form of a reactive expression
    treedata <- reactive({
      ShinyTreeMenu::treetestdata
    })

    # Use the shiny callModule to render the ShinyTreeMenu
    # Note that you should not include () when adding your reactive treedata
    shiny::callModule(ShinyTreeMenu::renderShinyTreeMenu,
                      id = "treemenu",
                      treedata = treedata,
                      level_icons = "tree")

    # Here you will update the ShinyTreeMenu
    # As with the render function, you should not include () when adding your reactive treedata
    ShinyTreeMenu::updateShinyTreeMenu(
      treedata = treedata,
      treemenu_open = reactive({input$treemenu_open}),
      level_icons = "tree")

    # For the purpose of displaying the selection functionality
    observeEvent(input$treemenu, {
      showModal(
        modalDialog(
          paste("Selected id:", input$treemenu$val,
                "| Selected level:", input$treemenu$level,
                "| Selected row:", input$treemenu$row)
        )
      )
    })


  }

)
```
