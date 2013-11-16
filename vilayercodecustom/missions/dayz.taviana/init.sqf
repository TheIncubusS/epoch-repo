startLoadingScreen ["", "DayZ_loadingScreen"];
enableSaving [false, false];

dayZ_instance = 13814;
hiveInUse = true;
initialized = false;
dayz_previousID = 0;

call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\variables.sqf";				// Initilize the Variables (IMPORTANT: Must happen very early)
call compile preprocessFileLineNumbers "\kh\dayztaviana\init\variables.sqf";
progressLoadingScreen 0.1;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\publicEH.sqf";					// Initilize the publicVariable event handlers
progressLoadingScreen 0.2;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\medical\setup_functions_med.sqf";	// Functions used by CLIENT for medical
progressLoadingScreen 0.4;
call compile preprocessFileLineNumbers "\kh\dayztaviana\init\compiles.sqf";						// Compile regular functions
progressLoadingScreen 1.0;

"filmic" setToneMappingParams [0.153, 0.357, 0.231, 0.1573, 0.011, 3.750, 6, 4]; setToneMapping "Filmic";

player setVariable ["BIS_noCoreConversations", true];
//enableRadio false; // Disable global chat radio messages

if (isServer) then { 		// If mission is loaded by server execute the server monitor
	hiveInUse = true;
	_serverMonitor = [] execVM "\z\addons\dayz_server\system\server_monitor.sqf";
};

if (!isDedicated) then {  	// If mission is loaded by a player execute the player monitor
	0 fadeSound 0;
	0 cutText [(localize "STR_AUTHENTICATING"), "BLACK FADED", 60];
	_id = player addEventHandler ["Respawn", {_id = [] spawn player_death;}];
	_playerMonitor = [] execVM "\z\addons\dayz_code\system\player_monitor.sqf";
	
	[] execVM "actions.sqf";
	
	#include "gcam\gcam_config.hpp"
	#include "gcam\gcam_functions.sqf"

	#ifdef GCAM
		waitUntil {(!isNull Player) and (alive Player) and (player == player)};
		waituntil {!(IsNull (findDisplay 46))};

		if (serverCommandAvailable "#kick") then { (findDisplay 46) displayAddEventHandler ["keyDown", "_this call fnc_keyDown"]; };
	#endif
};