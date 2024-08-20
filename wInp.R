# Write script file from vector of lines
wInp <- function(script, name = "inp.inp")
{
  sink(paste("lrt_in/", name, sep = ""))
  for (iLine in 1:length(script))
  {
    cat(script[iLine])
    cat("\n")
  }
  sink()
}
