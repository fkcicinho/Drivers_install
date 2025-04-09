cls


$default_path = "c:\program files\server_drivers" # Trocar pelo hostname da máquina que será o server

# Construção das pastas 
$val_path  = Test-Path -path $default_path 



if ($val_path -eq $false){
        mkdir $default_path

}


# Obtendo os dados da máquina
$model = Get-WmiObject win32_computersystem
$model = $model.Model


Write-Host "
(1) Install drivers local
(2) Extrair drivers local
(3) Install drivers em rede
(4) extrair drivers em rede
(5) Sair
"

$options = Read-Host "Escolha uma opção "



switch ($options) {
# install drivers local

"1" {
        $val_model = Test-Path -Path "$default_path\$model"
          
       
        # Não existe os drivers no servidor
        
        if ($val_model -eq $false) {msg * /w "Driver do modelo: $Model não foram encontrados no servidor" ; exit} 
        
        else {
               
               gci "$default_path\$model" -Recurse -Filter *.inf

               pause

                

        
        } 


        

    
}

# Extração dos drivers local
"2" {
        $path_model = "$default_path\$model"


        md $path_model # Criação da pasta no servidor


        $drivers = pnputil /enum-drivers


        $filtro_drivers = $drivers | Select-string "Class Name"


        $filtro_drivers | ForEach-Object {
            
            $teste = Test-Path -path "$path_model\$_" 

            write-host "Dessa forma que esta vindo o resultado: $path_model\$_" 

            

            pause
            
            if ($teste -eq $false) {md "$path_model\$_" }
        
        
        }


}



default {
    write-host "Opção incorreta"

}




}