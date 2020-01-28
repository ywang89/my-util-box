
#' Transform a Leetcode JSON data file into csv format
#'
#' Transform Leetcode's data files of Database problems, which is often in
#' JSON format, to be in csv format. The csv file can then be imported into
#' Postgres. The csv file is saved in the same directory as that of the
#' JSON file.
#'
#' @param path A string of characters indicating the path of json data file
#' @param file.name A string of characters representing the json file name, excluding extension ".json"
#'
#' @return NA
#' @export
#'

transformLeetcodeJsonToCsv = function(path, file.name){

  result = rjson::fromJSON(file = paste(path, file.name, ".json", sep = ""))

  data.by.row = result[["rows"]][[1]]
  df.result =
    data.frame(matrix(unlist(data.by.row),
                      nrow = length(data.by.row),
                      byrow = TRUE),
               stringsAsFactors = FALSE)
  colnames(df.result) = result[[1]][[1]]

  write.csv(df.result, paste(path, file.name, ".csv", sep = ""),
            row.names = FALSE, quote = TRUE)

  return(NA)
}
