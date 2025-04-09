cls




# Caminho onde os drivers foram exportados
$sourcePath = "c:\temp\drivers"
# Caminho onde você quer organizar os drivers
$destinationPath = "c:\temp\teste"

# Crie a pasta de destino, caso não exista
if (-not (Test-Path -Path $destinationPath)) {
    New-Item -Path $destinationPath -ItemType Directory
}

# Obter todos os drivers exportados
$drivers = Get-ChildItem -Path $sourcePath

# Para cada driver, mova para a pasta da classe
foreach ($driver in $drivers) {
    # Obtenha a classe do dispositivo (isso pode ser ajustado para ler do arquivo de driver ou do WMI)
    $classGuid = (Get-WmiObject Win32_PnPSignedDriver | Where-Object { $_.InfName -eq $driver.Name }).ClassGuid
    $classFolder = [System.Guid]::NewGuid($classGuid).ToString()

    # Crie uma pasta para a classe, se não existir
    $classFolderPath = Join-Path -Path $destinationPath -ChildPath $classFolder
    if (-not (Test-Path -Path $classFolderPath)) {
        New-Item -Path $classFolderPath -ItemType Directory
    }

    # Mover o driver para a pasta correspondente à classe
    Move-Item -Path $driver.FullName -Destination $classFolderPath
}
