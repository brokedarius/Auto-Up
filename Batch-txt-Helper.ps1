ForEach ($Item in $Args) { 

$Name = [System.IO.Path]::GetFileNameWithoutExtension($Item)

New-Item -ItemType file -Path "C:\Users\$Env:USERNAME\Desktop\UPLOADS\PRESENTATIONS" -Name $Name`_i.txt;

GCI -LiteralPath "C:\Users\$Env:USERNAME\Desktop\UPLOADS\PRESENTATIONS" -Filter $Name`_i.txt | Add-Content -Value "Category-EMP
Category-PB

Taglist

PRESENTATION

[SCREENS]";

}

Read-Host 'Done, Press Enter to Exit';

Exit
