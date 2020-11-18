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

private _emptyString = { [_this,EMPTY_STRING] select (_this == ""); };
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

_embeds = _embeds apply {
	private _title = getText(_x >> "title") call _formatString;
	private _description = getText(_x >> "description") call _formatString;
	private _url = getText(_x >> "url") call _emptyString;
	private _color = getText(_x >> "color") call _formatString;
	private _timestamp = getNumber(_x >> "timestamp");
	private _thumbnail = getText(_x >> "thumbnail") call _emptyString;
	private _image = getText(_x >> "image") call _emptyString;

	// tobool
	private _timestamp = _timestamp isEqualTo 1;

	// Author things
	private _authorName = getText(_x >> "Author" >> "name") call _formatString;
	private _author = if (_authorName == EMPTY_STRING) then {[]} else {
		[
			_authorName,
			getText(_x >> "Author" >> "url") call _emptyString,
			getText(_x >> "Author" >> "image") call _emptyString
		]
	};

	// Footer things
	private _footerText = getText(_x >> "Footer" >> "text") call _formatString;
	private _footer = if (_footerText == EMPTY_STRING) then {[]} else {
		[
			_footerText,
			getText(_x >> "Footer" >> "image") call _emptyString
		]
	};

	// Field things
	private _fields = getArray(_x >> "fields") apply {
		_x params [
			["_fieldName","",[""]],
			["_fieldContent","",[""]],
			["_fieldInline",0,[0]]
		];
		[
			_fieldName call _formatString,
			_fieldContent call _formatString,
			_fieldInline isEqualTo 1
		]
	};

	[_title,_description,_url,_color,_timestamp,_thumbnail,_image,_author,_footer,_fields]
};

[_webhookurl,_message,_username,_avatar,_tts,_embeds] call DiscordEmbedBuilder_fnc_send;
