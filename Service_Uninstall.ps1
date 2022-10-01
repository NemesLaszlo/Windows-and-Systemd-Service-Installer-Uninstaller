If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "You do not have Administrator rights to run this script`nPlease re-run this script as an Administrator"
    Read-Host -Prompt "Press Enter to exit"
    Break
}

$serviceName = "NameOfTheService"

Write-Host "Attempting to stop service: $serviceName..."
$service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

if($service)
{
    Stop-Service -name $serviceName
    Write-Host "Stopped service: $serviceName"
    Remove-Service -Name $serviceName
    Write-Host "Uninstalled service: $serviceName"
}
else
{
    Write-Host "Service: $serviceName is not found"
}