
try {  
Import-Module -Name WindowsAutoPilotIntune -ErrorAction Stop
Import-Module Microsoft.Graph.Intune -ErrorAction Stop
Import-Module WindowsAutopilotIntune -ErrorAction Stop
}
catch {  
throw 'Prerequisites not installed (WindowsAutoPilotIntune PowerShell module not installed'
}

$tenantID = "No"
$authority = "https://login.microsoftonline.com/$tenant"
$clientId = "No"
$SecuredPassword = "No"
$AppId = "No"
$Tag = "SCCMIMAGED"

$SecuredPasswordPassword = ConvertTo-SecureString `
-String $SecuredPassword -AsPlainText -Force

$ClientSecretCredential = New-Object `
-TypeName System.Management.Automation.PSCredential `
-ArgumentList $clientId, $SecuredPasswordPassword

Connect-MgGraph -TenantId $tenantID -ClientSecretCredential $ClientSecretCredential
#Get-AutopilotDevice
###################################################################

Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Confirm:$false -Force:$true
Install-Script get-windowsautopilotinfo -Confirm:$false -Force:$true
get-windowsautopilotinfo -Online -TenantId $tenantID -AppId $AppId -AppSecret $SecuredPassword -GroupTag $Tag








