cls


# Filtrando pelo arquivo .inf 
$Drivers = gci -Path "c:\temp\drivers" -File -Recurse -filter *.inf 


# Pasta que vão os drivers organizados
$folder_organization = "C:\temp\organizedDrivers"


$Drivers.Name | ForEach-Object {
   # Obtendo a class do driver
   $Driver_class =  Get-Content $Drivers.FullName | Where-Object { $_ -match "Class=" }


   # Removendo o Class= do resultado
   $new = $Driver_class -replace "^Class=", ""  | ForEach-Object {


        # Criação das pastas
        if (!(Test-Path "$folder_organization\$_") ) {New-Item -path "C:\temp\organizedDrivers\$_" -ItemType Directory   }
    
           
   }
   
   
   
   
     
  


}












# Get-Content "C:\caminho\para\driver.inf" | Where-Object { $_ -match "Class=" }

