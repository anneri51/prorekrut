

loopfolder

sub loopfolder ()

Const v_SourceFolder = "C:\Users\crmt\Downloads"
Const v_SourceFileNamePart = "Applicants_dlText"
<<<<<<< HEAD
Const v_DestinationFolder = "C:\Users\crmt\Documents\Visual Studio 2017\GEO\GEO_04_Serverdaten\03_Adressdaten\02_Website_download\Kandidaten"
=======
Const v_DestinationFolder = "C:\Users\crmt\Documents\Visual Studio 2017\GEO\GEO_04_Serverdaten\03_Adressdaten\02_Website_download\Firmen"
>>>>>>> master
v_date = mid(now(),7,4) & mid(now(),4,2) & mid(now(),1,2)


Set objFSO = CreateObject("Scripting.FileSystemObject")

' Get folder name to process off the command line, make sure it's valid

    If Not objFSO.FolderExists(v_SourceFolder) Then
        WScript.StdErr.WriteLine "Specified folder does not exist."
        WScript.Quit
    End If

    If Not objFSO.FolderExists(v_DestinationFolder) Then
        WScript.StdErr.WriteLine "Specified folder does not exist."
        WScript.Quit
    End If


' Access the folder to process
Set objSrcFolder = objFSO.GetFolder(v_SourceFolder)
if not objFSO.FolderExists(v_DestinationFolder & "\" &  v_date) then
  Set objDestFolder = objFSO.CreateFolder(v_DestinationFolder & "\" &  v_date)
else 
  set objDestFolder = objFSO.GetFolder(v_DestinationFolder & "\" &  v_date)
end if

<<<<<<< HEAD
'msgbox (v_date & v_SourceFolder)

' Process all files
WScript.Echo "Start Moving Files - Kandidaten"
=======
msgbox (v_date & v_SourceFolder)

' Process all files
>>>>>>> master
For Each objSrcFile In objSrcFolder.Files
    ' Get full path to file
    strPath = objSrcFile.Path
    ' Only convert CSV files
    If instr(UCase(objSrcFile.Name), UCase(v_SourceFileNamePart ))>0  Then
<<<<<<< HEAD
      'msgbox( v_SourceFolder & "\" &  objSrcFile.Name & ":" & v_DestinationFolder & "\" &  v_date & "\" & objSrcFile.Name)

       v_src = v_SourceFolder & "\" &  objSrcFile.Name
       v_dest =  v_DestinationFolder & "\" &  v_date & "\" & objSrcFile.Name

       CopyFile v_src, v_dest 

=======
  '    msgbox( v_SourceFolder & "\" &  objSrcFile.Name & ":" & v_DestinationFolder & "\" &  v_date & "\" & objSrcFile.Name)
   v_src = v_SourceFolder & "\" &  objSrcFile.Name
  v_dest =  v_DestinationFolder & "\" &  v_date & "\" & objSrcFile.Name
       CopyFile v_src, v_dest 
>>>>>>> master
    End If
Next

'Wrap up

<<<<<<< HEAD
Set objFSO = Nothing

WScript.Echo "End Moving Files - Kandidaten" 
=======
Set objFSO = Nothing 
>>>>>>> master

end sub





Sub CopyFile(SourceFile, DestinationFile)

    Set fso = CreateObject("Scripting.FileSystemObject")

    'Check to see if the file already exists in the destination folder
    Dim wasReadOnly
    wasReadOnly = False
    If fso.FileExists(DestinationFile) Then
        'Check to see if the file is read-only
        If fso.GetFile(DestinationFile).Attributes And 1 Then 
            'The file exists and is read-only.
<<<<<<< HEAD
            'WScript.Echo "Removing the read-only attribute"
=======
            WScript.Echo "Removing the read-only attribute"
>>>>>>> master
            'Remove the read-only attribute
            fso.GetFile(DestinationFile).Attributes = fso.GetFile(DestinationFile).Attributes - 1
            wasReadOnly = True
        End If

<<<<<<< HEAD
        'WScript.Echo "Deleting the file"
=======
        WScript.Echo "Deleting the file"
>>>>>>> master
        fso.DeleteFile DestinationFile, True
    End If

    'Copy the file
<<<<<<< HEAD
    'WScript.Echo "Copying " & SourceFile & " to " & DestinationFile
=======
    WScript.Echo "Copying " & SourceFile & " to " & DestinationFile
>>>>>>> master
    fso.CopyFile SourceFile, DestinationFile, True
    fso.DeleteFile SourceFile, True

    If wasReadOnly Then
        'Reapply the read-only attribute
        fso.GetFile(DestinationFile).Attributes = fso.GetFile(DestinationFile).Attributes + 1
    End If

    Set fso = Nothing

End Sub