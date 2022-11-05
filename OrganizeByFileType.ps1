# Description: 
# This program organizes files by their fileTypes 
# into folders named after each extenstion (jpg, exe, docx, etc.)

# Author:
# Matt Goulding

#params
param($source,$destination)

#functions
function Test-Folder($folder,[switch]$create) { 
    # Test if folder exists
    $folderExists = Test-Path $folder

    # If the folder doesn't exist and the create switch is used then create the folder
    # The create switch is only used for destination so that is the only time it will go into the if portion of the statement
    if (($folderExists -ne "True") -and ($create)) {
        #If the folder can't be created then throw an error.
        if (!(New-Item -Path $folder -ItemType directory)) {
            throw "Cannot create '$folder' folder."
        }
        else {
            Write-Host "'$folder' created!"
        }
    # If the folder doesn't exist then throw an error.
    } elseif (($folderExists -ne "True")) {
        throw "'$folder' not found. Try again."
    # Print out a success
    } else {
        "'$folder' found!"
    }

}

function Get-FolderStats($folder) {
    Write-Host "$folder stats: "
    $folderBytes = 0; Get-ChildItem -Path $folder | ForEach-Object { $folderBytes=$folderBytes + $_.Length }; Write-Host "Bytes: $folderBytes B "
    $folderFiles = 0; Get-ChildItem -Path $folder | ForEach-Object { $folderFiles=$folderFiles + 1 }; Write-Host "NumFiles: $folderFiles`n"
}

# main

Write-Host "`n`nTESTING FOLDER INPUTS: "
Write-Host "*******************************************"
# Test for source and destination
Test-Folder($source)
Test-Folder($destination) -create
Write-Host "*******************************************`n`n"



Write-Host "FINDING FILE EXTENSIONS, CREATING DIRECTORIES, AND SORTING: "
Write-Host "*******************************************"
# Find all the extensions present in source folder
$fileTypes = Get-Childitem -path $source | Select-Object -Unique @{label='ext';expression={$_.Extension.substring(1)}}
# Create a directory in the destination for each file extension. Throw an error if it can't create them. This is most likely because the extension folders already exist.
if (!($fileTypes | ForEach-Object {New-Item -Path $destination -ItemType directory -Name $_.ext})) {
    throw "Cannot create extension subfolders. Check to make sure they are not already created."
}
# Print message for each file being moved
Get-Childitem -path $source | ForEach-Object {Write-Host "Moving: $($_)"}
# Move each file from the source folder to the corresponding extension subfolder of the destination path
$fileTypes | ForEach-Object {Copy-Item -Path "$source/*.$($_.ext)" -Destination "$destination/$($_.ext)"}
Write-Host "*******************************************`n`n"

Write-Host "DISPLAYING EXTENSION FOLDER STATS: "
Write-Host "*******************************************"
Get-ChildItem $destination | ForEach-Object {Get-FolderStats($_)}
Write-Host "*******************************************`n`n"

# CHANGE TO MOVE-ITEM ON LINE 64 BEFORE SUBMITTING!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# **********************************************************************************************************
# **********************************************************************************************************
# **********************************************************************************************************
# **********************************************************************************************************
# **********************************************************************************************************
# **********************************************************************************************************
# **********************************************************************************************************
# **********************************************************************************************************
# **********************************************************************************************************
# **********************************************************************************************************
# **********************************************************************************************************
# **********************************************************************************************************
# **********************************************************************************************************
# **********************************************************************************************************
