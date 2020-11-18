/* ----------------------------------------------------------------------------
Project:
	https://github.com/ConnorAU/SQFDiscordEmbedBuilder

Author:
	ConnorAU - https://github.com/ConnorAU

Function:
	DiscordEmbedBuilder_fnc_buildSqf

Description:
	Builds a message from the sqf provided

Information:
	https://github.com/ConnorAU/SQFDiscordEmbedBuilder/wiki/Build-with-SQF

Return:
	BOOL - true if the message was sent to the extension
---------------------------------------------------------------------------- */

/*
Example 1:
[
	"Example",
	"This is an example message",
	"Example Name",
	"https://discord.com/assets/2c21aeda16de354ba5334551a883b481.png",
	false
] call DiscordEmbedBuilder_fnc_buildSqf;

Example 2:
[
	"Example",
	"This is another example message",
	"Different username, same webhook",
	"",
	false,
	[
		[
			"My Embed Title",
			"My Embed Description",
			"https://arma3.com/",
			"00FF00",
			true,
			"https://arma3.com/assets/img/wallpapers/1/9/arma3_white_plain_800x600.jpg",
			"https://arma3.com/assets/img/wallpapers/low/3/Arma%203%20Laws%20of%20War_wallpaper_1024x768.jpg",
			[
				profileName,
				"https://steamcommunity.com/id/_connor",
				"https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/1e/1e3c83b65d6f34cc9708eae853e8bc9848865dd1_full.jpg"
			],
			[
				"This is the footer text",
				"https://steamcdn-a.opskins.media/steamcommunity/public/images/apps/107410/3212af52faf994c558bd622cb0f360c1ef295a6b.jpg"
			],
			[
                ["Field 1","Content 1",true],
                ["Field 2","Some words",true],
                ["Field 3",":+1:",false],
                ["Field 4","__Markdown works here__",false]
			]
		],
		[
			"Second embed",
			"This embed uses [productVersion](https://community.bistudio.com/wiki/productVersion) as the sqf parameter",
			"",
			"",
			true,
			"",
			"",
			[],
			[],
			[
				["Product Name",format["%1",productVersion select 0],true],
				["Product Name Short",format["%1",productVersion select 1],true],
				["Product Version",format["%1",productVersion select 2],true],
				["Product Build",format["%1",productVersion select 3],true],
				["Product Branch",format["%1",productVersion select 4],true],
				["Has Mods",format["%1",productVersion select 5],true],
				["Platform",format["%1",productVersion select 6],true],
				["Architecture",format["%1",productVersion select 7],true],
				["All",format["You can use sqf parameters in the message, username, embed title, embed description, author name, footer text, field name and field content.\n**Discord** markdown `is` also _supported_.\n```sqf\n%1```",productVersion],false]
			]
		]
	]
] call DiscordEmbedBuilder_fnc_buildSqf;
*/

// The extension deserializer doesn't like empty strings, so this string is reserved as empty
#define EMPTY_STRING toString[1]

if !(uiNamespace getVariable ["DiscordEmbedBuilder_LoadSuccess",false]) exitwith {false};

private _emptyString = { [_this,EMPTY_STRING] select (_this == ""); };

params [
	["_webhookName","",[""]],
	["_message","",[""]],
	["_username","",[""]],
	["_avatar","",[""]],
	["_tts",false,[true]],
	["_embeds",[],[[]]]
];

private _webhookurl = getText(configFile >> "CfgDiscordEmbedWebhooks" >> _webhookName);
_embeds = _embeds apply {
	_x params [
		["_title","",[""]],
		["_description","",[""]],
		["_url","",[""]],
		["_color","",[""]],
		["_timestamp",false,[true]],
		["_thumbnail","",[""]],
		["_image","",[""]],
		["_author",[],[[]]],
		["_footer",[],[[]]],
		["_fields",[],[[]]]
	];

	// Bare bones
	_title = _title call _emptyString;
	_description = _description call _emptyString;
	_url = _url call _emptyString;
	_color = _color call _emptyString;
	_thumbnail = _thumbnail call _emptyString;
	_image = _image call _emptyString;

	// Author things
	_author params [
		["_authorName","",[""]],
		["_authorURL","",[""]],
		["_authorImage","",[""]]
	];
	_authorName = _authorName call _emptyString;
	_author = if (_authorName == EMPTY_STRING) then {[]} else {
		[
			_authorName,
			_authorURL call _emptyString,
			_authorImage call _emptyString
		]
	};

	// Footer things
	_footer params [
		["_footerText","",[""]],
		["_footerImage","",[""]]
	];
	_footerText = _footerText call _emptyString;
	_footer = if (_footerText == EMPTY_STRING) then {[]} else {
		[
			_footerText,
			_footerImage call _emptyString
		]
	};

	// Field things
	_fields = _fields apply {
		_x params [
			["_fieldName","",[""]],
			["_fieldContent","",[""]],
			["_fieldInline",false,[true]]
		];
		[
			_fieldName call _emptyString,
			_fieldContent call _emptyString,
			_fieldInline
		]
	};

	[_title,_description,_url,_color,_timestamp,_thumbnail,_image,_author,_footer,_fields]
};

[_webhookurl,_message,_username,_avatar,_tts,_embeds] call DiscordEmbedBuilder_fnc_send;
