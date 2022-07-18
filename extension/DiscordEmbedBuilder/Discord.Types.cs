namespace DiscordEmbedBuilder
{
    public class Types
    {
        public class EmbedArray
        {
            public string title { get; set; } = "";
            public string description { get; set; } = "";
            public string url { get; set; } = "";
            public string color { get; set; } = "";
            public bool useTimestamp { get; set; } = false;
            public string thumbnail { get; set; } = "";
            public string image { get; set; } = "";
            public EmbedAuthor author { get; set; }
            public EmbedFooter footer { get; set; }
            public EmbedFields fields { get; set; }
        }
        public class EmbedAuthor
        {
            public string name { get; set; } = "";
            public string url { get; set; } = "";
            public string icon_url { get; set; } = "";
        }
        public class EmbedFooter
        {
            public string text { get; set; } = "";
            public string icon_url { get; set; } = "";
        }
        public class EmbedField
        {
            public string name { get; set; } = "";
            public string value { get; set; } = "";
            public bool inline { get; set; } = false;
        }

        // I don't know the best way to do this, I'm limited by my lack of C# knowledge and how I understand the deserializer to work
        public class EmbedsArray
        {
            public EmbedArray embed1 { get; set; }
            public EmbedArray embed2 { get; set; }
            public EmbedArray embed3 { get; set; }
            public EmbedArray embed4 { get; set; }
            public EmbedArray embed5 { get; set; }
            public EmbedArray embed6 { get; set; }
            public EmbedArray embed7 { get; set; }
            public EmbedArray embed8 { get; set; }
            public EmbedArray embed9 { get; set; }
            public EmbedArray embed10 { get; set; }
        }
        public class EmbedFields
        {
            public EmbedField field1 { get; set; }
            public EmbedField field2 { get; set; }
            public EmbedField field3 { get; set; }
            public EmbedField field4 { get; set; }
            public EmbedField field5 { get; set; }
            public EmbedField field6 { get; set; }
            public EmbedField field7 { get; set; }
            public EmbedField field8 { get; set; }
            public EmbedField field9 { get; set; }
            public EmbedField field10 { get; set; }
            public EmbedField field11 { get; set; }
            public EmbedField field12 { get; set; }
            public EmbedField field13 { get; set; }
            public EmbedField field14 { get; set; }
            public EmbedField field15 { get; set; }
            public EmbedField field16 { get; set; }
            public EmbedField field17 { get; set; }
            public EmbedField field18 { get; set; }
            public EmbedField field19 { get; set; }
            public EmbedField field20 { get; set; }
            public EmbedField field21 { get; set; }
            public EmbedField field22 { get; set; }
            public EmbedField field23 { get; set; }
            public EmbedField field24 { get; set; }
            public EmbedField field25 { get; set; }
        }
    }
}
