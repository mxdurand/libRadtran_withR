# Execute command script that run uvspec from Cygwin
wuss.exe <- function(script = "script.cmd", rm.after.exe = TRUE)
{
  system(command = script)
  if(rm.after.exe == TRUE){
    file.remove(script_name)
  }
}

# Write input file from template to increment over parameter
incInp <- function(template = "inp.inp", par = "sza", inc = seq(0,60,10), filepath = TRUE)
{
  file <- readLines(paste("lrt_in/", template, sep = ""))
  
  line <- grep(pattern = par, x = file)
  #print(paste(line, ": ", file[line], sep = ""))
  if(length(line) > 1){
    stop("More than one parameter found in input file, redefine the 'par' argument")
  }
  
  vline <- strsplit(file[line], " ")[[1]]
  #print(vline)
  if(par != vline[1]){
    stop("first word of line is not 'par' argument")
  }
  
  i = 0
  new_files <- vector()
  for (iInc in inc)
  {
    i = i + 1
    newline <- paste(vline[1], iInc, sep = " ")
    file[line] <- newline
    
    sub.template <- substring(template, 1, nchar(template)-4)
    new_filename <- paste(sub.template, "_", i, ".inp", sep = "")
    new_files <- append(new_files, values = new_filename)
    sink(paste("lrt_in/", new_filename, sep = ""))
    for (iLine in 1:length(file))
    {
      cat(file[iLine])
      cat("\n")
    }
    sink()
  }
  
  if(filepath == TRUE){
    return(new_files)
  }
}
