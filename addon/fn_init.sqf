/*──────────────────────────────────────────────────────┐
│   Author: Connor                                      │
│   Steam:  https://steamcommunity.com/id/_connor       │
│   Github: https://github.com/ConnorAU                 │
│                                                       │
│   Please do not modify or remove this comment block   │
└──────────────────────────────────────────────────────*/

with uiNamespace do {
	DiscordEmbedBuilder_SessionKey = compileFinal str("DiscordEmbedBuilder" callExtension "init");
	DiscordEmbedBuilder_LoadSuccess = str DiscordEmbedBuilder_SessionKey != "{}";
	if DiscordEmbedBuilder_LoadSuccess then {
		diag_log parseText "DiscordEmbedBuilder loaded successfully";
	} else {
		diag_log parseText "DiscordEmbedBuilder failed to load";
	};
};