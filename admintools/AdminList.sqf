// Epoch Admin Tools
//Replace 111111111 with your ID. 
SuperAdminList = [
"111111111", // <Your In-Game Name here>
"999999999" // <S-Admin In-Game Name>
];
AdminList = [
"999999999", // <Admin In-Game Name>
"999999999" // <Admin In-Game Name>
];
ModList = [
"999999999", // <Moderator In-Game Name>
"999999999" // <Moderator In-Game Name>
];

/*
	Broadcasts a message to the super admins when the admin tools are used.
	Default: false
*/
broadcastToolUse = false;


/*
	Log admin tool usage by your admins?
	This creates a log in your server\EpochAdminToolLogs\toolUsageLog.txt
	You MUST have the EpochAdminToolsUsageLogger.dll in the root server
	directory or this will not work. The tool will still work either way.
	This is divided into two categories.
*/
	/*
		A major tool is a strong tool with high possibility for exploiting:
		Teleport, god mode, ESP, infinite ammo, invisibility, crate spawns, 
		unlocking items, displaying lock codes...
		Default: true
	*/
	logMajorTool = true;

	/*
		A minor tool is a weak tool with low possibility for exploiting:
		grass off, skin change, weapon kits, flying, maintain area, admin build
		Default: true
	*/
	logMinorTool = true;




// DO NOT MODIFY ANYTHING BEYOND THIS POINT
AdminList = AdminList + SuperAdminList;
if(isNil "tempList") then {tempList = [];}; 

/*
	Determines default on or off for admin tools menu
	Set this to false if you want the menu to be off by default.
	F11 turns the tool off, F10 turns it on.
	Leave this as True for now, it is under construction.
*/
if (isNil "toolsAreActive") then {toolsAreActive = true;};


// load event handlers for logging
if(isDedicated) then {
	"usageLogger" addPublicVariableEventHandler {
		"EATadminLogger" callExtension (_this select 1);
	};
	"useBroadcaster" addPublicVariableEventHandler {
		toClient = (_this select 1);
		{(owner _x) publicVariableClient "toClient";} forEach entities "CAManBase";
	};
	"baseExporter" addPublicVariableEventHandler {
		"EATbaseExporter" callExtension (_this select 1);
	};
};

// Display to super admins
if ((getPlayerUID player) in SuperAdminList) then {
	"toClient" addPublicVariableEventHandler {
		systemChat (_this select 1);
	};
};

// Show the admin list has loaded
adminListLoaded = true;
diag_log("Admin Tools: AdminList.sqf loaded");
