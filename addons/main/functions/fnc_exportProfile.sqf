#include "..\script_component.hpp"
/*
 * Author: johnb43
 * Export a profile to the clipboard.
 *
 * Arguments:
 * 0: Profile index <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * 0 call map_marker_setter_main_fnc_exportProfile
 *
 * Public: No
 */

params ["_index"];

if (_index == -1) exitWith {
    [LLSTRING(invalidProfile), false, 10, 2] call ace_common_fnc_displayText;
};

// If ACE clipboard is not enabled
if (!isClass (configFile >> "ACE_Extensions" >> "ace_clipboard")) exitWith {
    [LLSTRING(aceClipboardDisabled), false, 10, 2] call ace_common_fnc_displayText;
};

private _profile = GETPRVAR(QGVAR(profileNames),[]) select _index;
private _settings = GETPRVAR(FORMAT_1(QGVAR(profile%1),_profile),[]);

// If profile is invalid, don't copy to clipboard
if (_settings isEqualTo []) exitWith {
    [LLSTRING(invalidProfile), false, 10, 2] call ace_common_fnc_displayText;
};

// Copy to the clipboard
"ace_clipboard" callExtension (str _settings + ";");
"ace_clipboard" callExtension "--COMPLETE--";

[format [LSTRING(profileCopiedClipboard), _profile], ICON_LOAD, GVAR(loadColorIcon), call CBA_fnc_currentUnit, 3] call ace_common_fnc_displayTextPicture;
