set WINDOW_NAME to "Identifiant Apple"
set DEACTIVATE_BUTTON to "Désactiver le relais privé"
set PRIVACY_RELAY_INDEX to 3

tell application "System Preferences"
 activate
 set the current pane to pane id "com.apple.preferences.AppleIDPrefPane"
end tell

delay 2

tell application "System Events"
    tell window WINDOW_NAME of process "System Preferences"
        set btmmBox to checkbox 1 of UI element 1 of row PRIVACY_RELAY_INDEX of table 1 of scroll area 1 of group 1
        tell btmmBox
            if (its value as boolean) then click btmmBox
        end tell
        --get value of btmmBox
    end tell
end tell

delay 1

tell application "System Events" to tell process "System Preferences"
    click button DEACTIVATE_BUTTON of sheet 1 of window "Identifiant Apple"
end tell

tell application "System Preferences" to quit