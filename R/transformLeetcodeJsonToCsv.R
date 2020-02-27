
#' Transform a Leetcode JSON data file into csv format
#'
#' Transform Leetcode's data files of Database problems, which is often in
#' JSON format, to be in csv format. The csv file can then be imported into
#' Postgres. The csv file is saved in the same directory as that of the
#' JSON file.
#'
#' @param path A string of characters indicating the path of json data file
#' @param file.name A string of characters representing the json file name, excluding extension ".json"
#' @param write.file A boolean, indicating whether to write files to path
#'
#' @return A list of dataframes; each one represents a table
#' @export
#'

transformLeetcodeJsonToCsv = function(path, file.name, write.file = TRUE){

  result = rjson::fromJSON(file = paste(path, file.name, ".json", sep = ""))

  file.list = list()

  for(i in 1:length(result[["rows"]])){
    data.by.row = result[["rows"]][[i]]
    df.result =
      data.frame(matrix(unlist(data.by.row),
                        nrow = length(data.by.row),
                        byrow = TRUE),
                 stringsAsFactors = FALSE)
    colnames(df.result) = result[["headers"]][[i]]
    table.name = names(result[["headers"]])[i]
    file.list[[table.name]] = df.result

    if(write.file){
      write.csv(df.result, paste(path, file.name, "-", table.name, ".csv", sep = ""),
                row.names = FALSE, quote = TRUE)
    }
  }

  return(file.list)
}
