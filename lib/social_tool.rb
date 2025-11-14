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

		client.search("#vibecoding OR #PromptEngineering OR #AI", result_type: 'recent').take(6).collect do |tweet|
			{
				text: "#{tweet.user.screen_name}: #{tweet.text}",
				url: tweet.url.to_s
			}
		end
	end

	def self.fallback_tweets
		[
			{
				text: "karpathy: There's a new kind of coding I call \"vibe coding\", where you fully give in to the vibes, embrace exponentials, and forget that the code even exists. It's possible because the LLMs are getting too good. #vibecoding",
				url: "https://x.com/karpathy/status/1886192184808149383"
			},
			{
				text: "AnthropicAI: You can now generate production-ready prompts in the Anthropic Console. Describe what you want to achieve, and Claude will use prompt engineering techniques like chain-of-thought reasoning. #PromptEngineering",
				url: "https://x.com/AnthropicAI/status/1788958483565732213"
			},
			{
				text: "MatthewBerman: Vibe coding will change the world. Don't let the fun name fool you. Before AI existed, semi-technical folks would download code templates, copy/paste from github/stackoverflow. #vibecoding",
				url: "https://x.com/MatthewBerman/status/1904943879381782787"
			},
			{
				text: "OpenAI: Introducing GPT-4o with enhanced capabilities for AI development. The model's creative writing ability has leveled up–more natural, engaging, and tailored writing. #AI #MachineLearning",
				url: "https://x.com/OpenAI/status/1859296125947347164"
			},
			{
				text: "GoogleDeepMind: We're presenting AlphaProteo: an AI system for designing novel proteins that bind more successfully to target molecules. It could help advance drug design and more. #AI #Science",
				url: "https://x.com/GoogleDeepMind/status/1831710991475777823"
			},
			{
				text: "zswitten: IMO you only need to know three prompt engineering techniques: 1. Show the model examples 2. Let it think before answering 3. Break down big tasks into small ones. #PromptEngineering",
				url: "https://x.com/zswitten/status/1752700765380997591"
			}
		]
	end
end