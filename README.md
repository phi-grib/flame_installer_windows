# Windows installer for Flame

## Overview
This repository contains scripts for generating a Windows installer for Flame, using the software InnoSetup (https://jrsoftware.org/isinfo.php)

This installer copies a version of Flame and Flame_API to a local Windows folder, installs miniconda3 (the executable is provided) and executes an script to create the flame environment, downloading from Internet all the packages required. Finally, the flame software is installed in the environment and flame is configured.

Once Flame has been installed, new runs of the installer can be used to update existing version of the environment or the code.

So far, the installer only supports 64 bits versions of Windows (due to the miniconda version provided) and requires Internet access. Future versions will contain a compressed version of the environment, thus not requiring Internet access for the install.

## Downloading the installer
An updated version of the Windows installer can be donwloaded from the Output directory 
