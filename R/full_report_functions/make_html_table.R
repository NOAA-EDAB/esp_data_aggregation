make_html_table <- function(x, col_names){
  if(is.null(x) == FALSE){
    if(nrow(x) > 0){
      output <- DT::datatable(x, 
                              rownames = FALSE,
                              colnames = col_names,
                              filter = list(position = 'top', 
                                            clear = FALSE),
                              extensions = 'Scroller',
                              options = list(search = list(regex = TRUE),
                                             deferRender = TRUE,
                                             scrollY = 200,
                                             scrollX = TRUE,
                                             scroller = TRUE,
                                             language = list(thousands = ",")))
      return(output)
      }else print("NO DATA")
  } else print("NO DATA")
}

make_html_table_thin <- function(x, col_names){
  if(is.null(x) == FALSE){
    if(nrow(x) > 0){
      output <- DT::datatable(x, 
                              rownames = FALSE,
                              colnames = col_names,
                              filter = list(position = 'top', 
                                            clear = FALSE),
                             # extensions = 'Scroller',
                              options = list(search = list(regex = TRUE),
                                             deferRender = TRUE,
                                             scrollY = 200,
                                             #scrollX = TRUE,
                                             #scroller = TRUE,
                                             language = list(thousands = ","),
                                             paging = FALSE))
      return(output)
    }else print("NO DATA")
  } else print("NO DATA")
}