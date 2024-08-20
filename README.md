# Set of function to help run libRadtran from R
Requires, [libRadtran](https://www.libradtran.org/doku.php) and [Cygwin](https://www.cygwin.com/) installed with all necessary dependencies. 

## Usage

Get the working directory and create folders for input and outputs or the model
```
path <- getwd()
initRtoUVSpec(path)
```

**After the folder are created, move "inp_ex.inp" the lrt_in folder**

Print an example input file 
```
inp <- pInp("inp_ex.inp")
inp
```

Modify input file to your liking
```
inpA <- inp[1:14]                   # Remove zenith and azimuth angles
inpA[10] <- "wavelength 250 900"    # Change wavelength range to [250,900]
inpA[13] <- "sza 30"                # Change solar zenith angle to 0
inpA[15] <- "altitude 0.0"          # Add altitude parameter
```

Write new input file
```
wInp(inpA, "inpA.inp")
pInp("inpA.inp")                    # Print it to check if file was written properly
```

Incrementing input files
```
ins <- incInp(template = "inpA.inp", par = "sza", inc = seq(0, 60, 10))
```

Run uvspec in batch run
```
outs <- bwuss(inFiles = ins, exe = TRUE)
```

Compile batch run in single data frame
```
df <- rOutp(outFiles = outs)
```

