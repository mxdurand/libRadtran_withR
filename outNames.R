# Get output filenames from input filenames
outNames <- function(inFiles = ins)
{
  names <- substring(inFiles, 1, nchar(inFiles)-4)
  outNames <- paste(names, ".txt", sep = "")
  return(outNames)
}
