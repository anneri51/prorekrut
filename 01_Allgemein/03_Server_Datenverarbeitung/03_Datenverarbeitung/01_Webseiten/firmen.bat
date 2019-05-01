d:
cd D:\09_Firmen\10_ProRekrut\git\01_Allgemein\03_Server_Datenverarbeitung\03_Datenverarbeitung\02_Datenziele\02_Firmen\01_Details\20190428
set /i zl = 0
for /r %%i in (*) do ( 
type %%i   >>../../aa_comp_coord_all.txt

 )
echo schleifendurchläufe: %zl%