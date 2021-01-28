testPath = "C:\Users\witha\Documents\Unified Functional Testing\GUITest2"
 Dim objFSO
 Set objFSO = CreateObject("Scripting.FileSystemObject")
 DoesFolderExist = objFSO.FolderExists(testPath)
 Set objFSO = Nothing
 If DoesFolderExist Then
 Dim qtApp
 Dim qtTest
 Set qtApp = CreateObject("QuickTest.Application")
 qtApp.Launch
 qtApp.Visible = True
 qtApp.Open testPath, False
 Set qtTest = qtApp.Test
 qtTest.Run
 qtTest.Close
 qtApp.Quit
 Else
 End If