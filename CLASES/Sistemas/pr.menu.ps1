Write-Host '------BIENVENIDO A PROYECT MENU-----'
Write-Host '------------------------------------'
Write-Host '------ELIGE UNA OPCIÓN:-------------'
Write-Host '-------1- CARPETAS------------------'
Write-Host '-------2- ARCHIVOS------------------'
$menu=
Switch($menu) {
1{
    Write-Host -BackgroundColor Red 'El numero seleccionado es el 1'
    }
        2{
            Write-Host '------BIENVENIDO A PROYECT MENU-----'
            Write-Host '------------------------------------'
            Write-Host '------ELIGE UNA OPCIÓN:-------------'
            Write-Host '-------1- CARPETAS------------------'
               Write-Host '-------2- ARCHIVOS------------------'
            $menu=
            Switch($menu) {
                1{
                    Write-Host -BackgroundColor Red 'El numero seleccionado es el 1'
                    $ruta1=Get-ChildItem C:\Users\alejandro\Desktop | Get-FileHash
                    $ruta2=Get-ChildItem  C:\Users\alejandro | Get-FileHash
                    $cont= 0 
                    $ Duplicados= @()

                    foreach ($hash in $ruta1){
                        foreach ($hash2 in $ruta2) {
                            if($hash.Hash -eq $hash2.Hash){
                            
                                $cont++
                                $ Duplicados += $hash.name
                             }
                        }
                    }
                    $ Duplicados >  C:\Users\alejandro\Desktop\duplicados.txt
                    write-host 'los duplicados son: ' $pathDuplicados
                    Write-Host 'se han guardado en : C:\Users\alejandro\Desktop\duplicados.txt' 
                    write-host 'hay' $cont 'en total'
                    }
                2{
                    Write-Host -BackgroundColor Red '----------ARCHIVOS------------------'
                    }
                    }
            }
3{
    Write-Host -BackgroundColor Red 'El numero seleccionado es el 3'
    }
4{
    Write-Host -BackgroundColor Red 'El numero seleccionado es el 4'
    }
5{
    Write-Host -BackgroundColor Red 'El numero seleccionado es el 5'
    }
6{
    Write-Host -BackgroundColor Red 'El numero seleccionado es el 6'
    }
7{
    Write-Host -BackgroundColor Red 'El numero seleccionado es el 7'
    }
8{
    Write-Host -BackgroundColor Red 'El numero seleccionado es el 8'
    }
9{
    Write-Host -BackgroundColor Red 'El numero seleccionado es el 9'
    }
}