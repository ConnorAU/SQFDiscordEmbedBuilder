using System;
using System.IO;
using System.Net.Http;
using System.Reflection;
using System.Threading.Tasks;

namespace DiscordEmbedBuilder
{
    internal class Tools
    {
        private static readonly string AssemblyPath = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
        private static readonly string ExtFilePath = Path.Combine(AssemblyPath, "DiscordEmbedBuilder");
        private static readonly string LogFilePath = Path.Combine(ExtFilePath, "logs");
        private static readonly string LogFileName = Path.Combine(LogFilePath, $"{DateTime.Now.ToString("yyyy-MM-dd.HH-mm-ss")}.DiscordEmbedBuilder.log");

        internal static void Logger(Exception e = null, string s = "", bool loop = false)
        {
            try
            {
                if (!Directory.Exists(ExtFilePath))
                    Directory.CreateDirectory(ExtFilePath);
                if (!Directory.Exists(LogFilePath))
                    Directory.CreateDirectory(LogFilePath);

                using (StreamWriter file = new StreamWriter(@LogFileName, true))
                {
                    if (e != null)
                        s = $"{e}";
                    if (s.Length > 0)
                        file.WriteLine($"{DateTime.Now.ToString("T")} - {s}");
                }
            }
            catch (Exception i)
            {
                if (!loop)
                    Logger(i, null, true);
            };
        }

        internal static string GenTimeEncode()
        {
            long ticks = DateTime.Now.Ticks;
            byte[] bytes = BitConverter.GetBytes(ticks);
            string id = Convert.ToBase64String(bytes).Replace('"', '_');
            return id;
        }

        internal static async Task LogAsyncReply(HttpContent responseContent)
        {
            string readResponse = "";
            using (var reader = new StreamReader(await responseContent.ReadAsStreamAsync()))
            {
                readResponse += await reader.ReadToEndAsync();
            }
            if (readResponse.Length > 0) Logger(null, $"AsyncRet: {readResponse}");
        }
    }
}
