# Initialization of folders
initRtoUVSpec <- function(path)
{
  if (substring(path, nchar(path)-1, nchar(path)) == "/"){
    inPath <- paste(path, "lrt_in/", sep = "")
    outPath <- paste(path, "lrt_out/", sep = "")
  } else {
    inPath <- paste(path, "/lrt_in/", sep = "")
    outPath <- paste(path, "/lrt_out/", sep = "")
  }
  dir.create(inPath)
  dir.create(outPath)
}

