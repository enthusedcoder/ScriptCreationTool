
; *** Start added by AutoIt3Wrapper ***
#include <AutoItConstants.au3>
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <StringConstants.au3>
; *** End added by AutoIt3Wrapper ***
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_SaveSource=y
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_requestedExecutionLevel=requireAdministrator
#AutoIt3Wrapper_Add_Constants=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <GuiEdit.au3>
#include <Constants.au3>
#include <Array.au3>

If Not FileExists ( @AppDataDir & "\createscript\settings.ini" ) Then
	If Not FileExists ( @AppDataDir & "\createscript" ) Then
		DirCreate ( @AppDataDir & "\createscript" )
	EndIf
	$folder = FileSelectFolder ( "Select the folder where you want to store saved scripts.", @MyDocumentsDir )
	If $folder = "" Then
		Exit
	Else
		IniWrite ( @AppDataDir & "\createscript\settings.ini", "Settings", "Script folder", $folder )
	EndIf
EndIf

#Region ### START Koda GUI section ### Form=c:\users\whiggs\onedrive\always script\form\script creator.kxf
$Form1 = GUICreate("Form1", 410, 375, 192, 124, BitOR($GUI_SS_DEFAULT_GUI, $DS_SETFOREGROUND), BitOR($WS_EX_TOPMOST, $WS_EX_WINDOWEDGE))
$Label1 = GUICtrlCreateLabel("File name", 160, 0, 89, 29)
GUICtrlSetFont(-1, 16, 400, 0, "MS Sans Serif")
$Input1 = GUICtrlCreateInput("", 38, 40, 337, 21)
GUIStartGroup()
$Radio1 = GUICtrlCreateRadio("powershell", 56, 80, 81, 17)
$Radio2 = GUICtrlCreateRadio("autoit", 152, 80, 57, 17)
$Radio3 = GUICtrlCreateRadio("Visual Basic Script", 232, 80, 113, 17)
GUIStartGroup()
$Label2 = GUICtrlCreateLabel("Script Content", 140, 112, 128, 29)
GUICtrlSetFont(-1, 16, 400, 0, "MS Sans Serif")
$Edit1 = GUICtrlCreateEdit("", 32, 152, 329, 169, BitOR($ES_AUTOVSCROLL, $ES_WANTRETURN, $WS_VSCROLL))
$Button1 = GUICtrlCreateButton("Create file", 152, 328, 105, 33, $BS_NOTIFY)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetCursor(-1, 0)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
$aRect = _GUICtrlEdit_GetRECT($Edit1)
$aRect[0] += 10
$aRect[1] += 10
$aRect[2] -= 10
$aRect[3] -= 10
_GUICtrlEdit_SetRECT($Edit1, $aRect)
While 1
	If _GUICtrlEdit_GetTextLen($Input1) > 0 And _GUICtrlEdit_GetTextLen($Edit1) > 0 And BitAND(GUICtrlGetState($Button1), 128) Then
		GUICtrlSetState($Button1, $GUI_ENABLE)
	EndIf
	If (_GUICtrlEdit_GetTextLen($Input1) = 0 Or _GUICtrlEdit_GetTextLen($Edit1) = 0) And BitAND(GUICtrlGetState($Button1), 64) Then
		GUICtrlSetState($Button1, $GUI_DISABLE)
	EndIf

	$nMsg = GUIGetMsg()
	Switch $nMsg

		Case $GUI_EVENT_CLOSE
			Exit

		Case $Input1
			If StringRight(GUICtrlRead($Input1), 4) = ".ps1" Then
				GUICtrlSetState($Radio2, $GUI_UNCHECKED)
				GUICtrlSetState($Radio3, $GUI_UNCHECKED)
				GUICtrlSetState($Radio1, $GUI_ENABLE)
				GUICtrlSetState($Radio1, $GUI_CHECKED)
				GUICtrlSetState($Radio2, $GUI_DISABLE)
				GUICtrlSetState($Radio3, $GUI_DISABLE)
			ElseIf StringRight(GUICtrlRead($Input1), 4) = ".au3" Then
				GUICtrlSetState($Radio1, $GUI_UNCHECKED)
				GUICtrlSetState($Radio3, $GUI_UNCHECKED)
				GUICtrlSetState($Radio2, $GUI_ENABLE)
				GUICtrlSetState($Radio2, $GUI_CHECKED)
				GUICtrlSetState($Radio1, $GUI_DISABLE)
				GUICtrlSetState($Radio3, $GUI_DISABLE)
			ElseIf StringRight(GUICtrlRead($Input1), 4) = ".vbs" Then
				GUICtrlSetState($Radio1, $GUI_UNCHECKED)
				GUICtrlSetState($Radio2, $GUI_UNCHECKED)
				GUICtrlSetState($Radio3, $GUI_ENABLE)
				GUICtrlSetState($Radio3, $GUI_CHECKED)
				GUICtrlSetState($Radio1, $GUI_DISABLE)
				GUICtrlSetState($Radio2, $GUI_DISABLE)
			Else
				If BitAND(GUICtrlGetState($Radio1), 128) Or BitAND(GUICtrlGetState($Radio2), 128) Or BitAND(GUICtrlGetState($Radio3), 128) Then
					GUICtrlSetState($Radio1, $GUI_ENABLE)
					GUICtrlSetState($Radio1, $GUI_UNCHECKED)
					GUICtrlSetState($Radio2, $GUI_ENABLE)
					GUICtrlSetState($Radio2, $GUI_UNCHECKED)
					GUICtrlSetState($Radio3, $GUI_ENABLE)
					GUICtrlSetState($Radio3, $GUI_UNCHECKED)
				EndIf
			EndIf

		Case $Edit1

		Case $Button1
			If GUICtrlRead($Radio1) = 4 And GUICtrlRead($Radio2) = 4 And GUICtrlRead($Radio3) = 4 Then
				If Not IsDeclared("sToolTipAnswer") Then Local $sToolTipAnswer
				$sToolTipAnswer = ToolTip("You need to select one of the script types item.", Default, Default, "Make a selection", 0, 0)
				Sleep(3000)
				ToolTip("")
			Else

				If GUICtrlRead($Radio1) = 1 Then
					If StringRight(GUICtrlRead($Input1), 4) = ".ps1" Then
						$file = IniRead ( @AppDataDir & "\createscript\settings.ini", "Settings", "Script folder", "error" ) & "\" & StringReplace(StringStripWS(GUICtrlRead($Input1), 3), " ", "_")
					Else
						$file = IniRead ( @AppDataDir & "\createscript\settings.ini", "Settings", "Script folder", "error" ) & "\" & StringReplace(StringStripWS(GUICtrlRead($Input1), 3), " ", "_") & ".ps1"
					EndIf

				ElseIf GUICtrlRead($Radio2) = 1 Then
					If StringRight(GUICtrlRead($Input1), 4) = ".au3" Then
						$file = IniRead ( @AppDataDir & "\createscript\settings.ini", "Settings", "Script folder", "error" ) & "\" & StringReplace(StringStripWS(GUICtrlRead($Input1), 3), " ", "_")
					Else
						$file = IniRead ( @AppDataDir & "\createscript\settings.ini", "Settings", "Script folder", "error" ) & "\" & StringReplace(StringStripWS(GUICtrlRead($Input1), 3), " ", "_") & ".au3"
					EndIf
				ElseIf GUICtrlRead($Radio3) = 1 Then
					If StringRight(GUICtrlRead($Input1), 4) = ".vbs" Then
						$file = IniRead ( @AppDataDir & "\createscript\settings.ini", "Settings", "Script folder", "error" ) & "\" & StringReplace(StringStripWS(GUICtrlRead($Input1), 3), " ", "_")
					Else
						$file = IniRead ( @AppDataDir & "\createscript\settings.ini", "Settings", "Script folder", "error" ) & "\" & StringReplace(StringStripWS(GUICtrlRead($Input1), 3), " ", "_") & ".vbs"
					EndIf
				Else
					SetError(3)
				EndIf
				If @error Then
					SetError(0)
				Else
					$hand = Null
					If FileExists($file) And Not filetextcompare(_GUICtrlEdit_GetText($Edit1), $file) Then
						ShellExecute($file, "", IniRead ( @AppDataDir & "\createscript\settings.ini", "Settings", "Script folder", "error" ), $SHEX_OPEN)
						#Region --- CodeWizard generated code Start ---

						;MsgBox features: Title=Yes, Text=Yes, Buttons=Yes, No, and Cancel, Icon=Warning
						If Not IsDeclared("iMsgBoxAnswer") Then Local $iMsgBoxAnswer
						$iMsgBoxAnswer = MsgBox($MB_YESNOCANCEL + $MB_ICONEXCLAMATION, "File Exists", 'The file already exists, but it appears the contents are different.  Would you like to replace the existing file?  Select "no" to rename.')
						Select
							Case $iMsgBoxAnswer = $IDYES
								If StringRight($file, 3) = "au3" Then
									$hand = FileOpen($file, $FO_OVERWRITE)
								Else
									$hand = FileOpen($file, 514)
								EndIf

								FileWrite($hand, _GUICtrlEdit_GetText($Edit1))
								FileClose($hand)
							Case $iMsgBoxAnswer = $IDNO
								$b = 0
								Do
									$b += 1
								Until Not FileExists(_GetFilenameDrive($file) & _GetFilenamePath($file) & _GetFilename($file) & "(" & $b & ")." & _GetFilenameExt($file))
								If StringRight($file, 3) = "au3" Then
									$hand = FileOpen(_GetFilenameDrive($file) & _GetFilenamePath($file) & _GetFilename($file) & "(" & $b & ")." & _GetFilenameExt($file), $FO_OVERWRITE)
								Else
									$hand = FileOpen(_GetFilenameDrive($file) & _GetFilenamePath($file) & _GetFilename($file) & "(" & $b & ")." & _GetFilenameExt($file), 514)
								EndIf
								FileWrite($hand, _GUICtrlEdit_GetText($Edit1))
								FileClose($hand)

							Case $iMsgBoxAnswer = $IDCANCEL

						EndSelect
						#EndRegion --- CodeWizard generated code Start ---
					Else
						If StringRight($file, 3) = "au3" Then
							$hand = FileOpen($file, $FO_OVERWRITE)
						Else
							$hand = FileOpen($file, 514)
						EndIf
						FileWrite($hand, _GUICtrlEdit_GetText($Edit1))
						FileClose($hand)
					EndIf
					_GUICtrlEdit_SetText($Edit1, "")
					GUICtrlSetData($Input1, "")
				EndIf

			EndIf

	EndSwitch
WEnd


Func filetextcompare($text1, $two)
	$same = True
	$arr = StringSplit($text1, @CRLF, $STR_NOCOUNT)
	$search2 = _ArraySearch ( $arr, "; Script Start - Add your code below here")
	If @error Then
		SetError(0)
	Else
		_ArrayDelete($arr, "0-" & $search2)
	EndIf
	$ext2 = _GetFilenameExt($two)
	$arr2 = FileReadToArray($two)
	$search = _ArraySearch($arr2, "; Script Start - Add your code below here")
	If @error Then
		SetError(0)
	Else
		_ArrayDelete($arr2, "0-" & $search)
	EndIf

	$hol = ""
	$hol2 = ""

	For $i = 0 To UBound($arr) - 1 Step 1
		If StringIsSpace($arr[$i]) Then
			$hol = $hol & $i & ";"
			ContinueLoop
		Else
			$arr[$i] = StringStripWS($arr[$i], 3)
			ContinueLoop
		EndIf
	Next
	_ArrayDelete($arr, StringTrimRight($hol, 1))
	For $i = 0 To UBound($arr2) - 1 Step 1
		If StringIsSpace($arr2[$i]) Then
			$hol2 = $hol2 & $i & ";"
			ContinueLoop
		Else
			$arr2[$i] = StringStripWS($arr2[$i], 3)
			ContinueLoop
		EndIf
	Next
	_ArrayDelete($arr2, StringTrimRight($hol2, 1))


	If UBound($arr) <> UBound($arr2) Then
		$same = False
	Else
		$same2 = True
		$where = 0
		$val1 = ""
		$val2 = ""
		For $i = 0 To UBound($arr2) - 1 Step 1
			If $arr[$i] <> $arr2[$i] Then
				$same2 = False
				$where = $i
				$val1 = $arr[$i]
				$val2 = $arr2[$i]
				ExitLoop
			Else
				ContinueLoop
			EndIf
		Next
		If $same2 Then
			$same = True
		Else
			$same = False
		EndIf
	EndIf
	Return $same
EndFunc   ;==>filetextcompare




Func _GetFilename($sFilePath)
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel = impersonate}!\\" & "." & "\root\cimv2")
	Local $oColFiles = $oWMIService.ExecQuery("Select * From CIM_Datafile Where Name = '" & StringReplace($sFilePath, "\", "\\") & "'")
	If IsObj($oColFiles) Then
		For $oObjectFile In $oColFiles
			Return $oObjectFile.FileName
		Next
	EndIf
	Return SetError(1, 1, 0)
EndFunc   ;==>_GetFilename

Func _GetFilenameExt($sFilePath)
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel = impersonate}!\\" & "." & "\root\cimv2")
	Local $oColFiles = $oWMIService.ExecQuery("Select * From CIM_Datafile Where Name = '" & StringReplace($sFilePath, "\", "\\") & "'")
	If IsObj($oColFiles) Then
		For $oObjectFile In $oColFiles
			Return $oObjectFile.Extension
		Next
	EndIf
	Return SetError(1, 1, 0)
EndFunc   ;==>_GetFilenameExt

Func _GetFilenameInt($sFilePath)
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel = impersonate}!\\" & "." & "\root\cimv2")
	Local $oColFiles = $oWMIService.ExecQuery("Select * From CIM_Datafile Where Name = '" & StringReplace($sFilePath, "\", "\\") & "'")
	If IsObj($oColFiles) Then
		For $oObjectFile In $oColFiles
			Return $oObjectFile.Name
		Next
	EndIf
	Return SetError(1, 1, 0)
EndFunc   ;==>_GetFilenameInt

Func _GetFilenameDrive($sFilePath)
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel = impersonate}!\\" & "." & "\root\cimv2")
	Local $oColFiles = $oWMIService.ExecQuery("Select * From CIM_Datafile Where Name = '" & StringReplace($sFilePath, "\", "\\") & "'")
	If IsObj($oColFiles) Then
		For $oObjectFile In $oColFiles
			Return StringUpper($oObjectFile.Drive)
		Next
	EndIf
	Return SetError(1, 1, 0)
EndFunc   ;==>_GetFilenameDrive

Func _GetFilenamePath($sFilePath)
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel = impersonate}!\\" & "." & "\root\cimv2")
	Local $oColFiles = $oWMIService.ExecQuery("Select * From CIM_Datafile Where Name = '" & StringReplace($sFilePath, "\", "\\") & "'")
	If IsObj($oColFiles) Then
		For $oObjectFile In $oColFiles
			Return $oObjectFile.Path
		Next
	EndIf
	Return SetError(1, 1, 0)
EndFunc   ;==>_GetFilenamePath


