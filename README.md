# Windows installer for Flame

## Overview
This repository contains scripts for generating a Windows installer for Flame, using the software InnoSetup (https://jrsoftware.org/isinfo.php). 

Two different compilation scripts are provided: `flame_setup_script_miniconda` and `flame_setup_script_self_contained`. 

- flame_setup_script_miniconda uses miniconda3 and an active Internet connection is needed during the installation. 
- flame_setup_script_self_contained is fully self-contained and does not requiere Internet connection. A packed conda environment containing all the Python libraries needed to run flame must be generated to create the installer. This is explained below.

This installer copies a version of Flame and Flame_API to a local Windows folder. By default we used `$HOME/Documents/Flame`, to minimize the access to parts of the filesystem where the user can have no writting permission




## Common libraries
In order to create a flame installer, both flame and flame_api repositories must be downloaded at the installer folder:

```bash
git clone https://github.com/phi-grib/flame.git --depth 1
git clone https://github.com/phi-grib/flame_API.git --depth 1
````

Empty folders for flame and flame_api are provided, so compiling can be tested beforehand.

## flame miniconda installer

To create a miniconda based flame installer, source directory has to be set at the innosetup script. Look for the directive
`define MySetupDir` and change the path to the path where instaler files are in your machine (`your_path_to/windows_installer/setup_miniconda/`)
This installer installs miniconda3 (the executable is provided) and executes an script to create the flame environment, downloading from Internet all the packages required. 
Finally, the flame software is installed in the environment and flame is configured. Once Flame has been installed, new runs of the installer 
can be used to update existing version of the environment or the code.
This installer only supports 64 bits versions of Windows (due to the miniconda version provided) and requires Internet access.


## flame self-contained installer

In this case, the creation and packing of a flame environment is needed.

1 - Create the environment.

At flame repository folder type:
```bash
conda env create -f environment.yml
```
This should create an environment (flame) with all requiered libraries inside. 

2 - Pack flame environment.

Once flame environment is installed, it needs to be packed. For this step conda-pack package is needed. It can be installed
through the conda repositories by typing:
```bash
conda install -c conda-forge conda-pack
```
Now, create a folder call flame_env and run the following command inside of the folder:
```bash
conda pack -n flame -o flame_env.zip
```

When the packing is finished, unzip the file and move the folder containing the environment (flame_env)
to the folder `setup_self_contained`

IMPORTANT! RDKit is often corrupted in this process, so I recommend replacing the `rdkit` localted at `\flame_installer_windows\setup_self_contained\flame_env\Lib\site-packages`
with a copy of the local version (usually located at `C:\Users\XXX\miniconda3\envs\flame\Lib\site-packages`)

3 - Set the path of installation source files (`your_path_to/windows_installer/setup_self_contained/`) at innosetup script:
	
`define MySetupDir "your_path_to/windows_installer/setup_self_contained/"`

4 - Compile the program by clicking on compile icon in innosetup. If something is missing (flame, flame_api, flame_env) or 
the paths are not set properly compilation will be aborted and the reason will pop up.


## Downloading the installer
An updated version of the Windows installer can be downloaded from the `Output`  directory present in each installer folder.


