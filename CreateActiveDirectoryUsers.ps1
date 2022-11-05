# Description:
# This program takes a list of users from a CSV file, creates a new Active Directory user for each, and then uploads the information about each new user to a different CSV file

# Authors:
# Thomas Lund, Keanna Nabrotzky, Jessie Spencer, Matt Goulding

# Params
param($csv, $outputfile, [switch]$ExportResults)

# Functions



# Creates users based on the object passed in
function Add-ADUser($newuser) {
    $Attributes = @{
        Enabled = $true

        UserPrincipalName = $newuser.UserName
        GivenName = $newuser.FirstName
        Surname = $newuser.LastName
    }
    New-AdUser @Attributes
}


# Main
$names = Import-CSV ./$csv
$names | Format-Table


# Goes through each person in the csv file and adds them as a new user
Foreach ($person in $names) {
    # ACTIVE DIRECTORY INSERT PERSON 
    Add-ADUser($person)
}

# If the ExportResults switch is specified it will take the new users info and export them to a new CSV file
if ($ExportResults) {
    $ADOutput = @()
    Foreach ($person in $names) {
        $ADOutput += (Get-ADUser -Identity "$($person.UserName)" | Select-Object SAMAccountName,SID)
    }
    
    $ADOutput | Export-Csv -Path $outputfile
}