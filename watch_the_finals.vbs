' ==============================================================================
' Veilleur en arrière-plan : THE FINALS & AutoHotkey
' ==============================================================================
' Ce script surveille en continu le lancement de THE FINALS (Easy Anti-Cheat).
' 1. Dès que le jeu ou son anti-triche démarre, il ferme automatiquement AutoHotkey.
' 2. Dès que le jeu est quitté, il relance automatiquement le script AHK.
' ==============================================================================

Option Explicit

Dim WshShell, objWMIService, fso
Dim ahkDir, ahkExe, ahkScript
Dim colSelf, shouldRelaunch, isGameActive

Set WshShell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")

' Détection dynamique du dossier contenant le script
ahkDir = fso.GetParentFolderName(WScript.ScriptFullName)

' Détection automatique de l'exécutable AutoHotkey v2
If fso.FileExists(ahkDir & "\AutoHotkey64.exe") Then
    ahkExe = ahkDir & "\AutoHotkey64.exe"
ElseIf fso.FileExists("C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe") Then
    ahkExe = "C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe"
ElseIf fso.FileExists("C:\Program Files\AutoHotkey\AutoHotkey64.exe") Then
    ahkExe = "C:\Program Files\AutoHotkey\AutoHotkey64.exe"
Else
    ahkExe = ""
End If

' Utilisation de ChrW pour garantir l'interprétation exacte des caractères Unicode
' ChrW(232) = è  |  ChrW(8226) = •
ahkScript = ahkDir & "\alt + " & ChrW(232) & " = " & ChrW(8226) & ".ahk"

' Vérification anti-doublon (empêche plusieurs veilleurs de tourner en même temps)
Set colSelf = objWMIService.ExecQuery("Select ProcessId, CommandLine from Win32_Process Where (Name = 'wscript.exe' Or Name = 'cscript.exe') And CommandLine Like '%" & WScript.ScriptName & "%'")
If colSelf.Count > 1 Then
    WScript.Quit
End If

shouldRelaunch = False

' Boucle de surveillance principale
Do
    isGameActive = CheckGameRunning()

    If isGameActive Then
        ' Le jeu ou son anti-triche est en cours d'exécution
        If CheckAhkRunning() Then
            ' AHK est actif : on le ferme immédiatement pour éviter le blocage Easy Anti-Cheat
            KillAutoHotkey()
            shouldRelaunch = True
        End If
    Else
        ' Le jeu n'est pas en cours d'exécution
        If shouldRelaunch Then
            ' Le jeu vient de se fermer : on attend 2 secondes puis on relance AHK
            WScript.Sleep 2000
            LaunchAutoHotkey()
            shouldRelaunch = False
        End If
    End If

    ' Pause de 1,5 seconde entre chaque vérification (consommation processeur = 0%)
    WScript.Sleep 1500
Loop

' Fonction qui vérifie si le jeu ou son anti-triche est actif
Function CheckGameRunning()
    Dim colProcs
    Set colProcs = objWMIService.ExecQuery( _
        "Select ProcessId from Win32_Process Where " & _
        "Name = 'Discovery.exe' Or " & _
        "Name = 'Discovery-Win64-Shipping.exe' Or " & _
        "Name = 'start_protected_game.exe' Or " & _
        "Name = 'EasyAntiCheat.exe' Or " & _
        "Name = 'EasyAntiCheat_EOS.exe'")
    CheckGameRunning = (colProcs.Count > 0)
End Function

' Fonction qui vérifie si AutoHotkey est en cours d'exécution
Function CheckAhkRunning()
    Dim colAhk
    Set colAhk = objWMIService.ExecQuery( _
        "Select ProcessId from Win32_Process Where " & _
        "Name = 'AutoHotkey64.exe' Or " & _
        "Name = 'AutoHotkey32.exe' Or " & _
        "Name = 'AutoHotkey.exe'")
    CheckAhkRunning = (colAhk.Count > 0)
End Function

' Sous-routine pour fermer AutoHotkey
Sub KillAutoHotkey()
    WshShell.Run "taskkill /F /IM AutoHotkey64.exe /IM AutoHotkey32.exe /IM AutoHotkey.exe", 0, True
End Sub

' Sous-routine pour relancer le script AutoHotkey
Sub LaunchAutoHotkey()
    If ahkExe <> "" Then
        WshShell.Run """" & ahkExe & """ """ & ahkScript & """", 0, False
    Else
        WshShell.Run """" & ahkScript & """", 0, False
    End If
End Sub
