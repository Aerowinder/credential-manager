$dir_cred = $env:userprofile + '\Credentials'
$null = $exit #Suppress PSUseDeclaredVarsMoreThanAssignments code warning.
$exit = $false

function Show-Credential {
    Clear-Host
    Write-Host 'Directory:' $dir_cred
    
    $files_cred = Get-ChildItem $dir_cred
    if ($null -ne $files_cred) {
        Write-Host 'Credentials:' $files_cred.Count
        Write-Host
        foreach ($cred in $files_cred) {Write-Host ($cred.Name -Replace '.xml','') -ForegroundColor Yellow}
    } else {
        Write-Host 'Credentials: 0'
    }

    Write-Host
}

New-Item -Path $dir_cred -ItemType Directory -Force | Out-Null

do {
    Show-Credential
    Write-Host '1. Create credential'
    Write-Host '2. Remove credential'
    Write-Host
    $opt = Read-Host 'Select Option (1, 2). Press any other key to exit'

    switch ($opt) {
        '1' {
            $userinput = Read-Host 'New Credential Name'
            Get-Credential | Export-CliXml -Path  ($dir_cred + '\' + $userinput + '.xml')
        }
        '2' {
            $userinput = Read-Host 'Remove Credential'
            Remove-Item -Path ($dir_cred + '\' + $userinput + '.xml') -Confirm:$false
        }
        default {$exit = $true}
    }
} until ($exit -eq $true)

#Changelog
#2022-12-02 - AS - v1 - Refactored for Git. Added listing and removal of credentials.
#2022-12-07 - AS - v2 - Added loop to perform multiple actions per script execution. Updated variable names.
#2022-12-07 - AS - v3 - Added directory and credential count to main screen. Removed list function; perform automatically instead.
