If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "You do not have Administrator rights to run this script`nPlease re-run this script as an Administrator"
    Read-Host -Prompt "Press Enter to exit"
    Break
}

$serviceName = "NameOfTheService"
$binaryPath = "$pwd\NewService.exe"
$startUpType = "Automatic"
$description = "This is a new Windows service"

Write-Host "Attempting to create service: $serviceName..."

if ((Test-Path $binaryPath)-eq $false)
{
    Write-Host "BinaryPath to service was not found: $binaryPath"
    Write-Host "Service was NOT installed"
    return
}

if (("Automatic", "Manual", "Disabled") -notcontains $startUpType)
{
    Write-Host "Value for startUpType parameter should be (Automatic or Manual or Disabled) and it was $startUpType"
    Write-Host "Service was NOT installed"
    return
}

Write-Host "Installing service: $serviceName"
New-Service -name $serviceName -binaryPathName $binaryPath -Description $description -displayName $serviceName -startupType $startUpType
Write-Host "Installed service: $serviceName"

Start-Service -serviceName $serviceName