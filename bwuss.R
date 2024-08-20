# Batch runs of wuss from vector of input files
bwuss <- function(inFiles = ins, exe = TRUE, outs = TRUE)
{
  vOut <- vector()
  for (iFile in inFiles)
  {
    inName <- iFile
    rootName <- strsplit(iFile, ".", fixed = TRUE)[[1]][1]
    outName <- paste(rootName, ".txt", sep = "")
    scriptName <- paste("script_", rootName, ".cmd", sep = "")
    vOut <- append(vOut, values = outName)
    
    wuss(inp = inName, outp = outName, script_name = scriptName, exe = exe)
  }
  
  if(outs == TRUE){
    return(vOut)
  }
}
