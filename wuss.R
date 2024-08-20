# Write command script to run uvspec from Cygwin
wuss <- function(inp = "in.inp", outp = "out.txt", script_name = "script.cmd", exe = TRUE, rm.after.exe = TRUE)
{
  if (substring(inp, nchar(inp)-3, nchar(inp)) != ".inp" ||
      substring(outp, nchar(outp)-3, nchar(outp)) != ".txt" || 
      substring(script_name, nchar(script_name)-3, nchar(script_name)) != ".cmd"){
    stop("input file not in .inp or output file not in .txt or script file not in .cmd format")
  }
  
  sink(script_name)
  cat("cd C:/cygwin64/bin/")
  cat("\n")
  cat("bash.exe")
  cat("\n")
  cat("C:/Users/Localadmin_durandma/Documents/libradtran/libRadtran-2.0.5/bin/uvspec < C:/Users/Localadmin_durandma/Dropbox/Work/R/libRadtran/lrt_in/")
  cat(paste(inp))
  cat(" > C:/Users/Localadmin_durandma/Dropbox/Work/R/libRadtran/lrt_out/")
  cat(paste(outp))
  sink()
  
  if(exe == TRUE){
    system(command = script_name)
  }
  
  if(rm.after.exe == TRUE){
    file.remove(script_name)
  }
}
