# Compute list of matrices for radiances 
mRad <- function(data = df)
{
  names <- colnames(data)
  lmat <- list()
  for(iROW in 1:nrow(data))
  {
    phis <- colnames(data)[grep(pattern = "phi", x = names)]
    phis <- gsub(pattern = "phi", x = phis, "")
    phis <- gsub(pattern = ".1", x = phis, "", fixed = T)
    phis <- as.numeric(as.character(phis))
    
    mus <- colnames(data)[grep(pattern = "umu", x = names)]
    mus <- gsub(pattern = "umu.", x = mus, "")
    mus <- as.numeric(as.character(mus))
    
    uus <- as.numeric(as.character(unname(unlist(data[iROW, grep(pattern = "uu", x = names)]))))
    
    M <- matrix(uus, ncol = length(phis), nrow = length(mus), byrow = TRUE)
    colnames(M) <- phis
    rownames(M) <- mus
    lmat[[iROW]] <- M
  }
  return(lmat)
}
