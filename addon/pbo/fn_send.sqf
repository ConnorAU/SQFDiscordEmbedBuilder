/* ----------------------------------------------------------------------------
Project:
	https://github.com/ConnorAU/SQFDiscordEmbedBuilder

Author:
	ConnorAU - https://github.com/ConnorAU

Function:
	DiscordEmbedBuilder_fnc_send

Description:
	Sends a built message to the extension to execute a discord webhook

Return:
	BOOL - true if the message was sent to the extension
---------------------------------------------------------------------------- */

if !(uiNamespace getVariable ["DiscordEmbedBuilder_LoadSuccess",false]) exitwith {false};

params [
	["_webhookurl","",[""]],
	["_message","",[""]],
	["_username","",[""]],
	["_avatar","",[""]],
	["_tts",false,[true]],
	["_embeds",[],[[]]]
];

private _key = uiNamespace getVariable ["DiscordEmbedBuilder_SessionKey",{""}];
"DiscordEmbedBuilder" callExtension [call _key,[_webhookurl,_message,_username,_avatar,_tts,_embeds]];
true
