your_platform <- "mac" # Choose one of the following: mac, linux or windows

if (your_platform=="mac"){
  install_type <- "mac.binary"
  options(install.packages.check.source = "no")
  cat(paste(
    "Make sure you have the commend line tools installed! This end, first", 
    "open the App Terminal and issue the following command: "), 
    "xcode-select -p",
    paste("If it indicates Xcode has not been installed execute this:"),
    "xcode-select --install",
    "And then again re-check whether the installation was successful.",
    sep = "\n")
} else if (your_platform=="windows"){
  install_type <- "win.binary"
  options(install.packages.check.source = "no")
  install.packages("pkgbuild", type = install_type); rtools_installed <- pkgbuild::has_rtools()
  if (!rtools_installed){
    stop(paste(
      "You should install Rtools before starting to install the packages. ",
      "Information on how to do so can be found here: \n",
      "https://ohdsi.github.io/Hades/rSetup.html#Installing_RTools", sep = "\n"))
  }
} else if (your_platform=="linux"){
  install_type <- "source"
  options(install.packages.check.source = "yes")
} else{
  stop(
    paste0(
      "Only one of the following OS is allowed ",
      "'mac', 'linux' or 'windows', ",
      "You chose '", your_platform, "', which is not allowed!"))
}

here_installed <- require("here")

if (isFALSE(here_installed)){
  install.packages("here", type = install_type); if (isFALSE(here_installed)){install.packages('here')}
} 

here_installed <- require("here")

if (isFALSE(here_installed)){
  cat(paste0(
    "WARNING! The package 'here' could not be installed!\n",
    "Please execute the following comment and make a screenshop from ",
    "resulting error message:\n",
    "install.packages('here')\n",
    "Then post the screenshot in the Moodle forum!"))
} else {
  cat("Package here has been installed successfully!")
}

required_packages_cran <- c(
  "AER",
  "countrycode",
  "data.table",
  "fitdistrplus",
  "gapminder",
  "ggpubr",
  "ggrepel",
  "haven",
  "ineq",
  "latex2exp",
  "learnr",
  "lmtest",
  "MASS",
  "moments",
  "optimx",
  "plm",
  "remotes",
  "rmarkdown",
  "rmutil",
  "quarto",
  "commonmark",
  "R.utils",
  "sandwich",
  "scales",
  "texreg",
  "tidyverse",
  "tinytex",
  "tufte",
  "viridis",
  "WDI"
)

install.packages(required_packages_cran) # , type = install_type

required_packages_github <- c(
  "rstudio/learnr",
  "rstudio/ggcheck",
  "rstudio/gradethis",
  "graebnerc/DataScienceExercises",
  "graebnerc/icaeDesign"
)

remotes::install_github(
  repo = required_packages_github, upgrade = "always")

required_packages <- c(
  required_packages_cran, 
  gsub(".*/","", required_packages_github)
  )

package_status_list <- list()
for (i in 1:length(required_packages)){
  package_name <- required_packages[i]
  print(package_name)
  package_installed <- require(package_name, 
                               character.only = T)
  status_frame <- data.frame(package=package_name, 
                             status=package_installed)
  package_status_list[[i]] <- status_frame
}

paket_log <- do.call("rbind", package_status_list)

log_path <- here::here("InstallationLog.txt")
write.table(x = paket_log, file = log_path, row.names = FALSE)

package_status_vector <- paket_log[["status"]]

if (sum(package_status_vector)==length(package_status_vector)){
  print("Excellent! All relevant packages were installed successfully!")
} else{
  cat(paste0(
    "Warning! There were errors when installing some packages!\n",
    "Please have a look into the file 'InstallationLog.txt'.",  
    "It was saved here: \n",
    log_path, "\n",
    "If there are only a few packages with a 'FALSE', please try to install ",
    "them separately by executing:\n",
    "install.packages('PACKAGENAME')\n",
    "if it is a package in the vector 'required_packages_cran'.\n",
    "If it is a package in the vector 'required_packages_github', then  run:\n",
    "remotes::install_github('PACKAGENAME', upgrade = 'always')\n",
    "where 'PACKAGENAME' is as in the vector 'required_packages_github'.\n",
    "Then make a screenshot of the resulting error message and ",
    "post the screenshot as well as the file 'InstallationLog.txt' in ",
    "the Moodle forum so that we can help you!"))
}
