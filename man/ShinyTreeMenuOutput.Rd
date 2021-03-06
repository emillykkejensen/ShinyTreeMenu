% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ShinyTreeMenuOutput.R
\name{ShinyTreeMenuOutput}
\alias{ShinyTreeMenuOutput}
\title{Render the ShinyTreeMenu HTML}
\usage{
ShinyTreeMenuOutput(outputId, class = NULL, width = "200px",
  height = "100vh")
}
\arguments{
\item{outputId}{output variable to read the value from}

\item{class}{character; Additional CSS classes to add to the div output}

\item{width}{character; A valid CSS unit - default is "200px". See details
for advanced options. (like "100\%" or "400px"). If NULL it will adapt to menu.}

\item{height}{character; A valid CSS unit - default is "100vh". See
details for advanced options.}
}
\description{
Render a reactive ShinyTreeMenu output variable in your Shiny UI.
}
\details{
\strong{Width and height:}

Besides the normal CSS unit like px, %, vh etc. you can use CSS
calculation to controle width and height. For example you can set the
height of the menu to the screen height minus 50 px, by setting
height = "calc(100vh - 50px)"
}
\examples{


if (interactive()) {

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

}

}
\seealso{
\code{\link{renderShinyTreeMenu}}, \code{\link{updateShinyTreeMenu}}
and \code{\link{ShinyTreeMenuHTML}}
}
