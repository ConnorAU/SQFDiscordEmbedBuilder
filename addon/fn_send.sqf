/*──────────────────────────────────────────────────────┐
│   Author: Connor                                      │
│   Steam:  https://steamcommunity.com/id/_connor       │
│   Github: https://github.com/ConnorAU                 │
│                                                       │
│   Please do not modify or remove this comment block   │
└──────────────────────────────────────────────────────*/

// The extension deserializer doesn't like empty strings, so this string is reserved as empty
#define EMPTY_STRING "DEB_EMPTY_STR"

if !(uiNamespace getVariable ["DiscordEmbedBuilder_LoadSuccess",false]) exitwith {};
params [["_template","",[""]],["_textParameters",[],[[]]]];

private _cfgDir = configFile >> "CfgDiscordEmbedBuilder" >> _template;
if (isNull _cfgDir) exitwith {false};

private _formatString = { 
	private _s = format([_this]+_textParameters);
	[EMPTY_STRING,_s] select (_s != "");
};

private _webhookurl = getText(_cfgDir >> "webhookurl");
private _message = getText(_cfgDir >> "message") call _formatString;
private _username = getText(_cfgDir >> "username") call _formatString;
private _avatar = getText(_cfgDir >> "avatar");
private _tts = getNumber(_cfgDir >> "tts") isEqualTo 1;
private _embeds = "true" configClasses (_cfgDir >> "embeds");

private ["_title","_description","_url","_color","_timestamp","_thumbnail","_image","_timestamp","_authorName","_authorURL","_authorImage","_author","_footerText","_footerImage","_footer","_fields"];
{
	
	_title = getText(_x >> "title") call _formatString;
	_description = getText(_x >> "description") call _formatString;
	_url = getText(_x >> "url");
	_color = getText(_x >> "color");
	_timestamp = getNumber(_x >> "timestamp");
	_thumbnail = getText(_x >> "thumbnail");
	_image = getText(_x >> "image");
	
	if (_url == "") then {_url = EMPTY_STRING};
	if (_color == "") then {_color = EMPTY_STRING};
	if (_thumbnail == "") then {_thumbnail = EMPTY_STRING};
	if (_image == "") then {_image = EMPTY_STRING};

	// tobool
	_timestamp = _timestamp isEqualTo 1;

	// Author things
	_authorName = getText(_x >> "Author" >> "name") call _formatString;
	_authorURL = getText(_x >> "Author" >> "url");
	_authorImage = getText(_x >> "Author" >> "image");
	if (_authorURL == "") then {_authorURL = EMPTY_STRING};
	if (_authorImage == "") then {_authorImage = EMPTY_STRING};
	_author = [[],[_authorName,_authorURL,_authorImage]] select (_authorName != "");

	// Footer things
	_footerText = getText(_x >> "Footer" >> "text") call _formatString;
	_footerImage = getText(_x >> "Footer" >> "image");
	if (_footerImage == "") then {_footerImage = EMPTY_STRING};
	_footer = [[],[_footerText,_footerImage]] select (_footerText != "");

	// Field things
	_fields = getArray(_x >> "fields") apply {
		_x params [
			["_fieldName","",[""]],
			["_fieldContent","",[""]],
			["_fieldInline",0,[0]]
		];

		if (_fieldName == "") then {_fieldName = EMPTY_STRING};
		if (_fieldContent == "") then {_fieldContent = EMPTY_STRING};

		[_fieldName call _formatString,_fieldContent call _formatString,_fieldInline isEqualTo 1];
	};

	_embeds set [_forEachIndex,[_title,_description,_url,_color,_timestamp,_thumbnail,_image,_author,_footer,_fields]];
} foreach _embeds;

private _key = uiNamespace getVariable ["DiscordEmbedBuilder_SessionKey",{""}];
"DiscordEmbedBuilder" callExtension [call _key,[_webhookurl,_message,_username,_avatar,_tts,_embeds]];
true