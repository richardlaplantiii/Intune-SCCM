

try {  
Import-Module -Name WindowsAutoPilotIntune -ErrorAction Stop
Import-Module Microsoft.Graph.Intune -ErrorAction Stop
Import-Module WindowsAutopilotIntune -ErrorAction Stop
Install-Module -Name Microsoft.PowerShell.SecretManagement -Force
Install-Module -Name Az.Accounts -Force
Install-Module -Name Az.KeyVault -Force
Install-Module -Name Az.Resources -Force
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Confirm:$false -Force:$true
Install-Script get-windowsautopilotinfo -Confirm:$false -Force:$true
}
catch {  
throw 'Prerequisites not installed installed'
}

#Disconnect any Active AZ accounts ... just in case
Disconnect-AzAccount


$tenantID="33191d6f-ca64-4904-a242-6fec4589294d"


#Connect to the Lift App to Middleman

Connect-AzAccount -ServicePrincipal -TenantId $tenantID -CertificateThumbprint "B93F54045761E94D40AF78DD429AC59303F102FA" -ApplicationId "19a5252a-f5be-47d0-8a44-75505e8aec08" 


#Obtain Appkey

$authority = "https://login.microsoftonline.com/$tenant"
$clientId = Get-AzKeyVaultSecret -VaultName DTS-Vault -Name OSDAPPCLIENTID -AsPlainText
$SecuredPassword = Get-AzKeyVaultSecret -VaultName DTS-Vault -Name OSDAPPKEY -AsPlainText


$SecuredPasswordPassword = ConvertTo-SecureString `
-String $SecuredPassword -AsPlainText -Force

$ClientSecretCredential = New-Object `
-TypeName System.Management.Automation.PSCredential `
-ArgumentList $clientId, $SecuredPasswordPassword

#Disconnect So the Script can reconnect ...someone else wrote it, and its super good ... so I aint changing it.
Disconnect-AzAccount

Get-windowsautopilotinfo -Online -TenantId $tenantID -AppId $clientId -AppSecret $SecuredPassword -GroupTag SCCMIMAGED








