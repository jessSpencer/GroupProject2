# Description:
# This script will print out a comprehensive list of information about a given computer

# Authors:
# Thomas Lund, Keanna Nabrotzky, Jessie Spencer, Matt Goulding

# Params
param($computer=".", $filePath="C:\")

# Functions

# TODO : Network connection, Network adapter, Disk Drive, Logical Drive, Physical Memory, Services
# ORDER : Computer Info, BIOS, OS, NetworkConnection, NetworkAdapter, NetworkAdapterConfiguration, logicalDisk, DiskDrive, Physical Memory, Users, Product, Service, Process

function Get-ComputerSystemProduct($computer) {
    return Get-WmiObject -Class Win32_ComputerSystemProduct -ComputerName $computer | Select-Object IdentifyingNumber, Name, Caption
}
function Get-Bios($computer) {
    return Get-WmiObject -Class Win32_BIOS -ComputerName $computer | Select-Object Manufacturer, Name, SerialNumber, BiosVersion
}

function Get-OperatingSystem($computer) {
    return Get-WmiObject -Class Win32_OperatingSystem -ComputerName $computer 
}

function Get-NetworkConnection($computer){

}

function Get-NetworkAdapter($computer){
    
}
function Get-NetworkAdapterConfiguration($computer) {
    return Get-WmiObject -Class Win32_NetworkAdapterConfiguration -ComputerName $computer | Select-Object Index, ServiceName, IPAddress, DHCPEnabled, Description, DatabasePath | Format-Table
}

function Get-DiskDrive($computer){

}
function Get-LogicalDrive($computer){
    
}

function Get-PhysicalMemory($computer) {
    
}

function Get-LocalUsers($computer) {
    return Get-WmiObject -ComputerName $computer -Class Win32_UserAccount -Filter "LocalAccount=True" | Select-Object Domain, FullName, Name, PasswordExpires, PasswordChangeable, PasswordRequired | Format-Table
}

function Get-Product($computer) {
    Get-WmiObject -Class Win32_Product -ComputerName $computer | Sort-Object InstallDate -Descending | Select-Object Name, Vendor, Version, InstallDate -First 20 | Format-Table
}

function Get-Services($computer){
    
}

function Get-Processes($computer) {
    return Get-WmiObject -Class Win32_process -ComputerName $computer | Sort-Object -Property Creation -Descending | Select-Object Name, Description, ExecutablePath -First 20 | Format-Table
}

# main

# Check to see if the outfile exists and delete it if it does
if (Test-Path $filePath) {
    Remove-Item $filePath -Force
}

# Create outfile
New-Item -Path $filePath -ItemType File



Out-File -FilePath $filePath -Append "`n`nDISPLAYING OS INFO: "
Out-File -FilePath $filePath -Append "*******************************************"
Out-File -FilePath $filePath -Append Get-OperatingSystem($computer)
Out-File -FilePath $filePath -Append "*******************************************`n`n"

Out-File -FilePath $filePath -Append "`n`nDISPLAYING BIOS INFO: "
Out-File -FilePath $filePath -Append "*******************************************"
Out-File -FilePath $filePath -Append Get-Bios($computer)
Out-File -FilePath $filePath -Append "*******************************************`n`n"

Out-File -FilePath $filePath -Append "`n`nDISPLAYING TOP SYSTEM PROCESSES: "
Out-File -FilePath $filePath -Append "*******************************************"
Out-File -FilePath $filePath -Append Get-Processes($computer)
Out-File -FilePath $filePath -Append "*******************************************`n`n"

Out-File -FilePath $filePath -Append "`n`nDISPLAYING NETWORK INFO: "
Out-File -FilePath $filePath -Append "*******************************************"
Out-File -FilePath $filePath -Append Get-NetworkAdapterConfiguration($computer)
Out-File -FilePath $filePath -Append "*******************************************`n`n"

Out-File -FilePath $filePath -Append "`n`nDISPLAYING MOST RECENTLY INSTALLED SOFTWARE: "
Out-File -FilePath $filePath -Append "*******************************************"
Out-File -FilePath $filePath -Append Get-InstalledSoftware($computer)
Out-File -FilePath $filePath -Append "*******************************************`n`n"

Out-File -FilePath $filePath -Append "`n`nDISPLAYING MOST RECENTLY INSTALLED SOFTWARE: "
Out-File -FilePath $filePath -Append "*******************************************"
Out-File -FilePath $filePath -Append Get-InstalledSoftware($computer)
Out-File -FilePath $filePath -Append "*******************************************`n`n"

