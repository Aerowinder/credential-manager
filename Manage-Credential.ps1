$dir_cred = $env:userprofile + '\Credentials'
New-Item -Path $dir_cred -ItemType Directory -Force

$null = $exit #Suppress PSUseDeclaredVarsMoreThanAssignments code warning.
$exit = $false

function Show-Credential {
    Clear-Host
    Write-Host 'Credentials Present:'
    Write-Host
    $files_cred = Get-ChildItem $dir_cred

    foreach ($cred in $files_cred) {Write-Host ($cred.Name -Replace '.xml','')}
    Write-Host
}

do {
    Clear-Host
    Write-Host 'c. Create credential'
    Write-Host 'r. Remove credential'
    Write-Host 'l. List credential'
    Write-Host
    $opt = Read-Host 'Select Option (c, r, l; any other key to exit)'

    switch ($opt) {
        'c' {
            Show-Credential
            $cred_newname = Read-Host 'New Credential Name'
            Get-Credential | Export-CliXml -Path  ($dir_cred + '\' + $cred_newname + '.xml')
        }
        'r' {
            Show-Credential
            $cred_remove = Read-Host 'Remove Credential'
            Remove-Item -Path ($dir_cred + '\' + $cred_remove + '.xml') -Confirm:$false
        }
        'l' {
            Show-Credential
            Read-Host 'Press any key to continue'
        }
        default {$exit = $true}
    }
} until ($exit -eq $true)

#Changelog
#2022-12-02 - AS - v1 - Refactored for Git. Added listing and removal of credentials.
#2022-12-07 - AS - v2 - Added loop to perform multiple actions per script execution. Updated variable names.
