# Compile dataframe from a single or batch run
rOutp <- function(outFiles = outs)
{
  # Get solver used in run
  inFile <- readLines(paste("lrt_in/", strsplit(outFiles[1], ".", fixed = T)[[1]][1], ".inp", sep = ""))
  solver <- strsplit(inFile[grep(pattern = "rte_solver", x = inFile)], " ")[[1]][2]
  
  # Get umu and phi angles if provided
  zen_line <- grep(pattern = "umu ", x = inFile)
  phi_line <- grep(pattern = "phi ", x = inFile)
  if(length(zen_line) == 0 && length(phi_line) == 0){
    no_angle <- TRUE
  } else {
    no_angle <- FALSE
    zen <- strsplit(inFile[zen_line], " ")[[1]]
    phi <- strsplit(inFile[phi_line], " ")[[1]]
    zen <- zen[2:length(zen)]
    phi <- phi[2:length(phi)]
  }
  
  # Find names of columns depending on solver and angles (umu/phi) provided
  if(solver == "disort"){
    if(no_angle == TRUE){
      COLS <- c("lambda", "edir", "edn", "eup", "uavgdir", "uavgdn", "uavgup")
    } else {
      COLS <- c("lambda", "edir", "edn", "eup", "uavgdir", "uavgdn", "uavgup", paste("phi", phi, sep = ""))
      for (iMu in zen)
      {
        COLS <- append(COLS, values = c(paste("umu", iMu, sep = ""), paste("u0u", iMu, sep = "")))
        for (iPhi in phi)
        {
          COLS <- append(COLS, values = c(paste("uu", iMu, "_", iPhi, sep = "")))
        }
      }
    }
  } else if(solver == "rodent" || solver == "twostr"){
    COLS <- c("lambda", "edir", "edn", "eup", "uavg")
  }
  
  # Get number of columns
  NCOL <- length(COLS)
  
  df0 <- data.frame()
  if(no_angle == TRUE){
    for (iFile in outFiles)
    {
      df <- read.table(paste("lrt_out/", iFile, sep = ""), header = F, sep = "", dec = ".")
      colnames(df) <- COLS
      df$file <- iFile
      df0 <- rbind(df0, df)
    }
  } else if(no_angle == FALSE){
    for (iFile in outFiles)
    {
      iFilePath <- paste("lrt_out/", iFile[1], sep = "")
      file <- readChar(iFilePath, nchars = file.size(iFilePath), useBytes = T)
      
      yfile <- strsplit(file, " ", fixed = T)[[1]]
      yfile <- yfile[yfile != ""]
      yfile <- gsub(pattern = "\r", replacement = "", x = yfile, fixed = TRUE)
      yfile <- gsub(pattern = "\n", replacement = "", x = yfile, fixed = TRUE)
      yfile <- yfile[yfile != ""]
      
      M <- matrix(as.numeric(yfile), ncol = NCOL, nrow = ceiling(length(yfile)/NCOL), byrow = TRUE)
      df <- data.frame(M)
      colnames(df) <- COLS
      df$file <- iFile
      df0 <- rbind(df0, df)
    }
  }
  return(df0)
}
