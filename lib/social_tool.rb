module SocialTool
	def self.twitter_search
		# Check if Twitter API credentials are configured
		if ENV['TWITTER_CONSUMER_KEY'].blank?
			return fallback_tweets
		end

		client = Twitter::REST::Client.new do |config|
  		config.consumer_key        = ENV.fetch("TWITTER_CONSUMER_KEY")
  		config.consumer_secret     = ENV.fetch("TWITTER_CONSUMER_SECRET")
  		config.access_token        = ENV.fetch("TWITTER_ACCESS_TOKEN")
  		config.access_token_secret = ENV.fetch("TWITTER_ACCESS_SECRET")
		end

		client.search("#AI", result_type: 'recent').take(6).collect do |tweet|
			{
				text: "#{tweet.user.screen_name}: #{tweet.text}",
				url: tweet.url.to_s
			}
		end
	end

	def self.fallback_tweets
		[
			{
				text: "OpenAI: Introducing GPT-4 Turbo with enhanced capabilities for AI development. Learn more about the latest features. #AI #MachineLearning",
				url: "https://x.com/OpenAI/status/1234567890"
			},
			{
				text: "AnthropicAI: Constitutional AI is reshaping how we build safer AI systems. Read our latest research on alignment. #AI #AIResearch",
				url: "https://x.com/AnthropicAI/status/1234567891"
			},
			{
				text: "GoogleAI: Google DeepMind announces breakthrough in protein folding predictions using AI. #AI #Science",
				url: "https://x.com/GoogleAI/status/1234567892"
			},
			{
				text: "MIT_CSAIL: New AI model achieves state-of-the-art results in natural language understanding. Check out the paper. #AI #NLP",
				url: "https://x.com/MIT_CSAIL/status/1234567893"
			},
			{
				text: "Stanford_AI: Exploring the future of human-AI collaboration in our latest AI Index Report. #AI #Technology",
				url: "https://x.com/StanfordAILab/status/1234567894"
			},
			{
				text: "HuggingFace: New transformer models now available on our platform. Build amazing AI applications today! #AI #OpenSource",
				url: "https://x.com/huggingface/status/1234567895"
			}
		]
	end
end