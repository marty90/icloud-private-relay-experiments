set WINDOW_NAME to "Apple ID"
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
            if not (its value as boolean) then click btmmBox
        end tell
        --get value of btmmBox
    end tell
end tell

tell application "System Preferences" to quit