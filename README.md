This shows how to extend the shiny::checkboxGroupInput by another checkbox at the top to select / deselect all checkboxes in the group.

# Features:
  * As the functionality is built with javascript, it does not need fancy server side coding and is always responsive.
  * The value of the all-selector checkbox is not sent to the server along with the original checkboxGroupInput you created.
    * The name of the all-selector checkbox can be changed. See at Usage below.
  * The all-selector will match the overall status of the checkboxes below:
    * If all checkboxes are on, then the all-selector is also on.
	* If any checkbox is off, the all-selector is off.
  * The all-selector is not part of the div of the original checkboxGroup. Thus limiting the height and adding a scrollbar will not including the all-selector. It will always be on top and visible.

# Installation:
  * Add the three functions at the top of shiny/app.R
  * Add the tags$head part in shiny/app.R into your ui. Note that the stylesheet is optional and is just there to show an example with a scrollbar.
  * Create a folder called www into your app folder and copy the shiny/www/custom.js there. Note: If you want the scrollbar as well, copy shiny/www/custom.css as well.
  
# Usage:
Write a checkboxGroupInput like you usually would do, but use the new function name:

```
checkboxGroupInputWithAllSelector(
  inputId = "test1"
  , label = "label1"
  , choices = LETTERS[1:10]
)
```

The name of the all-selector checkbox can be changed with the `allSelectorLabel` argument.