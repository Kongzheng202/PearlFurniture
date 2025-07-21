using System;
using System.Collections.Generic;

namespace PearlFurniture.Helpers
{
    public static class SentimentAnalyzer
    {
        private static readonly List<string> PositiveWords = new() { "good", "excellent", "great", "awesome", "love", "satisfied", "perfect" };
        private static readonly List<string> NegativeWords = new() { "bad", "poor", "terrible", "worst", "hate", "disappointed", "broken" };

        public static string AnalyzeComment(string comment)
        {
            comment = comment?.ToLower() ?? "";

            int score = 0;
            foreach (var word in PositiveWords)
                if (comment.Contains(word)) score++;

            foreach (var word in NegativeWords)
                if (comment.Contains(word)) score--;

            return score switch
            {
                > 0 => "Positive",
                < 0 => "Negative",
                _ => "Neutral"
            };
        }
    }
}
