/* ----------------------------------------------------------------------------
Project:
	https://github.com/ConnorAU/SQFDiscordEmbedBuilder

Author:
	ConnorAU - https://github.com/ConnorAU

Function:
	DiscordEmbedBuilder_fnc_buildCfg

Description:
	Builds a message from the config template provided

Information:
	https://github.com/ConnorAU/SQFDiscordEmbedBuilder/wiki/Build-with-config-templates

Return:
	BOOL - true if the message was sent to the extension
---------------------------------------------------------------------------- */

// The extension deserializer doesn't like empty strings, so this string is reserved as empty
#define EMPTY_STRING toString[1]

if !(uiNamespace getVariable ["DiscordEmbedBuilder_LoadSuccess",false]) exitwith {false};
params [["_template","",[""]],["_textParameters",[],[[]]]];

private _cfgDir = configFile >> "CfgDiscordEmbedBuilder" >> _template;
if (isNull _cfgDir) exitwith {false};

private _emptyString = { [EMPTY_STRING,_this] select (_this != ""); };
private _formatString = {
	params [["_str","",[""]],["_replaceEmpty",true,[true]]];
	private _str = format([_str]+_textParameters);
	if _replaceEmpty then {_str call _emptyString} else {_str}
};

private _webhookurl = getText(configFile >> "CfgDiscordEmbedWebhooks" >> getText(_cfgDir >> "webhook"));
private _message = [getText(_cfgDir >> "message"),false] call _formatString;
private _username = [getText(_cfgDir >> "username"),false] call _formatString;
private _avatar = getText(_cfgDir >> "avatar");
private _tts = getNumber(_cfgDir >> "tts") isEqualTo 1;
private _embeds = "true" configClasses (_cfgDir >> "embeds");

private ["_title","_description","_url","_color","_timestamp","_thumbnail","_image","_timestamp","_authorName","_authorURL","_authorImage","_author","_footerText","_footerImage","_footer","_fields"];
{
	_title = getText(_x >> "title") call _formatString;
	_description = getText(_x >> "description") call _formatString;
	_url = getText(_x >> "url") call _emptyString;
	_color = getText(_x >> "color") call _formatString;
	_timestamp = getNumber(_x >> "timestamp");
	_thumbnail = getText(_x >> "thumbnail") call _emptyString;
	_image = getText(_x >> "image") call _emptyString;

	// tobool
	_timestamp = _timestamp isEqualTo 1;

	// Author things
	_authorName = getText(_x >> "Author" >> "name") call _formatString;
	_authorURL = getText(_x >> "Author" >> "url") call _emptyString;
	_authorImage = getText(_x >> "Author" >> "image") call _emptyString;
	_author = [[],[_authorName,_authorURL,_authorImage]] select (_authorName != EMPTY_STRING);

	// Footer things
	_footerText = getText(_x >> "Footer" >> "text") call _formatString;
	_footerImage = getText(_x >> "Footer" >> "image") call _emptyString;
	_footer = [[],[_footerText,_footerImage]] select (_footerText != EMPTY_STRING);

	// Field things
	_fields = getArray(_x >> "fields") apply {
		_x params [
			["_fieldName","",[""]],
			["_fieldContent","",[""]],
			["_fieldInline",0,[0]]
		];
		[_fieldName call _formatString,_fieldContent call _formatString,_fieldInline isEqualTo 1];
	};

	_embeds set [_forEachIndex,[_title,_description,_url,_color,_timestamp,_thumbnail,_image,_author,_footer,_fields]];
} foreach _embeds;

[_webhookurl,_message,_username,_avatar,_tts,_embeds] call DiscordEmbedBuilder_fnc_send;
