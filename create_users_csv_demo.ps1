# create_users_csv_demo.ps1
# Demo-only Active Directory User Automation (CSV-driven)
# Domain: demo.local, OU=OU=DemoUsers,DC=demo,DC=local
# No real AD required

Import-Module ActiveDirectory -ErrorAction SilentlyContinue


function Generate-SecurePassword {
    $length = 14
    $chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()'
    -join ((1..$length) | ForEach-Object { $chars[(Get-Random -Maximum $chars.Length)] })
}


param(
    [string]$CsvPath = ".\users.csv",
    [string]$OU = "OU=DemoUsers,DC=demo,DC=local"
)

$Users = Import-Csv -Path $CsvPath
$Log = @()

foreach ($User in $Users) {
    $Username = "$($User.FirstName).$($User.LastName)"
    $Password = Generate-SecurePassword
    $SecurePass = ConvertTo-SecureString $Password -AsPlainText -Force
    $HomePath = "\\DemoServer\Home\$Username"

    try {
        New-ADUser -Name "$($User.FirstName) $($User.LastName)" `
                   -SamAccountName $Username `
                   -UserPrincipalName "$Username@demo.local" `
                   -Path $OU `
                   -AccountPassword $SecurePass `
                   -Enabled $true
        Write-Host "Demo user $Username created successfully!"

        # Simulate adding to groups
        $Groups = @()
        if ($User.Groups) { $Groups = $User.Groups -split ";" }
        foreach ($G in $Groups) {
            Write-Host "Adding $Username to group $G (demo)"
        }

        # Simulate home folder creation
        Write-Host "Creating home folder at $HomePath (demo)"

        # Simulate Azure Key Vault secret
        $SecretFromVault = "DemoSecretValue"
        Write-Host "Retrieved secret from Azure Key Vault (demo): $SecretFromVault"

        $Log += [pscustomobject]@{User=$Username; Status="Created"; Home=$HomePath; Time=(Get-Date)}
    } catch {
        Write-Warning "Demo error creating $Username: $($_.Exception.Message)"
        $Log += [pscustomobject]@{User=$Username; Status="Failed"; Home=$HomePath; Time=(Get-Date)}
    }
}

$Log | Export-Csv -Path ".\onboarding_run_log_demo.csv" -NoTypeInformation -Force
Write-Host "Demo run completed. Log exported to onboarding_run_log_demo.csv"
