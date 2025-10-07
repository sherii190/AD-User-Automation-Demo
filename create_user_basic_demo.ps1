# create_user_basic_demo.ps1
# Demo-only Active Directory User Automation
# Domain: demo.local, OU=OU=DemoUsers,DC=demo,DC=local
# No real AD required, script is safe for demonstration

Import-Module ActiveDirectory -ErrorAction SilentlyContinue


function Generate-SecurePassword {
    $length = 14
    $chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()'
    -join ((1..$length) | ForEach-Object { $chars[(Get-Random -Maximum $chars.Length)] })
}


param(
    [string]$FirstName = "Alice",
    [string]$LastName  = "Johnson",
    [string]$OU        = "OU=DemoUsers,DC=demo,DC=local"
)

$Username = "$FirstName.$LastName"
$Password = Generate-SecurePassword
$SecurePass = ConvertTo-SecureString $Password -AsPlainText -Force

try {
    New-ADUser -Name "$FirstName $LastName" `
               -SamAccountName $Username `
               -UserPrincipalName "$Username@demo.local" `
               -Path $OU `
               -AccountPassword $SecurePass `
               -Enabled $true
    Write-Host "Demo user $Username created successfully!"
} catch {
    Write-Warning "This is a demo script — AD module may not be installed. $($_.Exception.Message)"
}

# Optional: simulate Azure Key Vault secret retrieval (demo only)
$SecretFromVault = "DemoSecretValue"
Write-Host "Retrieved secret from Azure Key Vault (demo): $SecretFromVault"
