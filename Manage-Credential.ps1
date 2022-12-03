$cred_path = $env:userprofile + '\Credentials'
New-Item -Path $cred_path -ItemType Directory -Force

Clear-Host
Write-Host 'c. Create credential'
Write-Host 'r. Remove credential'
Write-Host 'l. List credential'
Write-Host
$opt = Read-Host 'Select Option (c, r)'


function Show-Credential {
    Clear-Host
    Write-Host 'Credentials Present:'
    Write-Host
    $cred_files = Get-ChildItem $cred_path

    foreach ($cred in $cred_files) {Write-Host ($cred.Name -Replace '.xml','')}
    Write-Host
}

switch ($opt) {
    'c' {
        Show-Credential
        $cred_new_name = Read-Host 'Credential Name'
        Get-Credential | Export-CliXml -Path  ($cred_path + '\' + $cred_new_name + '.xml')
    }
    'r' {
        Show-Credential
        $cred_remove = Read-Host 'Remove Credential'
        Remove-Item -Path ($cred_path + '\' + $cred_remove + '.xml') -Confirm:$false
    }
    Default {Show-Credential}
}

#Changelog
#2022-12-02 - AS - v1 - Refactored for Git. Added listing and removal of credentials.