# Este script establece cmd.exe como la terminal predeterminada en lugar de Windows Terminal

# Deshabilitar el terminal moderno
Set-ItemProperty -Path "HKCU:\Console" -Name "ForceV2" -Value 0

# Función para establecer cmd.exe como la aplicación predeterminada para una extensión dada
function Set-CmdAsDefault {
    param (
        [string]$extension
    )

    $userChoicePath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\$extension\UserChoice"

    if (-not (Test-Path $userChoicePath)) {
        New-Item -Path $userChoicePath -Force
    }

    New-ItemProperty -Path $userChoicePath -Name "Progid" -Value "Applications\cmd.exe" -Force
}

# Establecer cmd.exe como la aplicación predeterminada para archivos .cmd y .bat
Set-CmdAsDefault -extension ".cmd"
Set-CmdAsDefault -extension ".bat"

Write-Output "cmd.exe establecido como la aplicación predeterminada para .cmd y .bat"
