
#' Transform a Leetcode JSON data file into csv format

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
