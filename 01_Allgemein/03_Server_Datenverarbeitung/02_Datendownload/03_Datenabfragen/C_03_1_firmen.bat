d:
rem cd D:\GitProjekte\02_proj2_prorekrut\git\01_Allgemein\03_Server_Datenverarbeitung\04_Datenupload\01_src_data\
cd C:\Users\crmt\Documents\Visual Studio 2017\GEO\GEO_04_Serverdaten\03_Adressdaten
cd 02_Firmen\01_Details
for /r %%i in (*) do type %%i   >>../aa_comp_coord_all.txt