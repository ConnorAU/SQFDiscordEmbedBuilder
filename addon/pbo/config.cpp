/*──────────────────────────────────────────────────────┐
│   Author: Connor                                      │
│   Steam:  https://steamcommunity.com/id/_connor       │
│   Github: https://github.com/ConnorAU                 │
│                                                       │
│   Please do not modify or remove this comment block   │
└──────────────────────────────────────────────────────*/

// You don't need to worry about this stuff
#include "\@DiscordEmbedBuilder\external\_config.cpp"
class CfgPatches {
	class DiscordEmbedBuilder {
        name="DiscordEmbedBuilder";
        author="Connor";
        url="https://steamcommunity.com/id/_connor";

		requiredVersion=1.68;
		requiredAddons[]={};
		units[]={};
		weapons[]={};
	};
};
class CfgFunctions {
	class DiscordEmbedBuilder {
		class Scripts {
            file = "\DiscordEmbedBuilder";
			class init {preInit=1;};
			class buildCfg {};
			class buildSqf {};
			class send {};
		};
	};
};