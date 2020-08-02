/*──────────────────────────────────────────────────────┐
│   Author: Connor                                      │
│   Steam:  https://steamcommunity.com/id/_connor       │
│   Github: https://github.com/ConnorAU                 │
│                                                       │
│   Please do not modify or remove this comment block   │
└──────────────────────────────────────────────────────*/

// Developer info: https://github.com/ConnorAU/SQFDiscordEmbedBuilder/blob/master/README.md

class CfgDiscordEmbedWebhooks {
    // https://discord.com/api/webhooks/000000000000000000/XXXXXXX_XXXXXXXXXXXXXXX_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    Example="000000000000000000/XXXXXXX_XXXXXXXXXXXXXXX_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
};

class CfgDiscordEmbedTemplate {
    title="";
    description="";
    url="";
    color="";
    timestamp=0;
    thumbnail="";
    image="";
    class Author {
        name="";
        url="";
        image="";
    };
    class Footer {
        text="";
        image="";
    };
    // Maximum 25 fields per embed
    fields[]={
        //{title,content,inline}
    };
};

class CfgDiscordEmbedBuilder {
	#include "\@DiscordEmbedBuilder\external\Example.cpp"
	#include "\@DiscordEmbedBuilder\external\Example2.cpp"
};
