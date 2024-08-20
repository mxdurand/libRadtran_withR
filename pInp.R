# Print input file
pInp <- function(filename)
{
  if(substring(filename, nchar(filename)-3, nchar(filename)) == ".inp"){
    file <- readLines(paste("lrt_in/", filename, sep = ""))
  } else {
    file <- readLines(paste("lrt_in/", filename, ".inp", sep = ""))
  }
  return(print(file))
}
