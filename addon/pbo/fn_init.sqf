/* ----------------------------------------------------------------------------
Project:
	https://github.com/ConnorAU/SQFDiscordEmbedBuilder

Author:
	ConnorAU - https://github.com/ConnorAU

Function:
	DiscordEmbedBuilder_fnc_init

Description:
	Initialises the discord embed builder mod
---------------------------------------------------------------------------- */

with uiNamespace do {
	DiscordEmbedBuilder_SessionKey = compileFinal str("DiscordEmbedBuilder" callExtension "init");
	DiscordEmbedBuilder_LoadSuccess = str DiscordEmbedBuilder_SessionKey != "{}";
	if DiscordEmbedBuilder_LoadSuccess then {
		diag_log parseText "DiscordEmbedBuilder loaded successfully";
	} else {
		diag_log parseText "DiscordEmbedBuilder failed to load";
	};
};
