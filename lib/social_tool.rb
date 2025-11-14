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
		all_tweets = [
			# #vibecoding tweets
			{
				text: "karpathy: There's a new kind of coding I call \"vibe coding\", where you fully give in to the vibes, embrace exponentials, and forget that the code even exists. It's possible because the LLMs are getting too good. #vibecoding",
				url: "https://x.com/karpathy/status/1886192184808149383"
			},
			{
				text: "MatthewBerman: Vibe coding will change the world. Don't let the fun name fool you. Before AI existed, semi-technical folks would download code templates, copy/paste from github/stackoverflow. #vibecoding",
				url: "https://x.com/MatthewBerman/status/1904943879381782787"
			},
			{
				text: "karpathy: I just vibe coded a whole iOS app in Swift (without having programmed in Swift before, though I learned some in the process) and now ~1 hour later it's actually running on my physical phone. #vibecoding",
				url: "https://x.com/karpathy/status/1903671737780498883"
			},
			{
				text: "rileybrown_ai: Vibe Coding: The act of using only your voice in Cursor Composer to build apps, forgetting the code even exists. Complete Video Tutorial. #vibecoding",
				url: "https://x.com/rileybrown_ai/status/1887524152380158251"
			},
			# #PromptEngineering tweets
			{
				text: "AnthropicAI: You can now generate production-ready prompts in the Anthropic Console. Describe what you want to achieve, and Claude will use prompt engineering techniques like chain-of-thought reasoning. #PromptEngineering",
				url: "https://x.com/AnthropicAI/status/1788958483565732213"
			},
			{
				text: "zswitten: IMO you only need to know three prompt engineering techniques: 1. Show the model examples 2. Let it think before answering 3. Break down big tasks into small ones. #PromptEngineering",
				url: "https://x.com/zswitten/status/1752700765380997591"
			},
			{
				text: "BritneyMuller: 6 Reasons Why Most Prompt Engineering Tips Are BS + A Better Framework: Give it a role, offer it a tip, give the model time to think... #PromptEngineering",
				url: "https://x.com/BritneyMuller/status/1785667290316378407"
			},
			{
				text: "mattshumer_: Here's my insanely powerful GPT-4.5 prompt for writing viral X posts. Feed it your favorite viral tweets + your own idea, and it spits out an optimized tweet. #PromptEngineering",
				url: "https://x.com/mattshumer_/status/1910014022889660541"
			},
			# #AI tweets
			{
				text: "OpenAI: Introducing GPT-4o with enhanced capabilities for AI development. The model's creative writing ability has leveled up–more natural, engaging, and tailored writing. #AI #MachineLearning",
				url: "https://x.com/OpenAI/status/1859296125947347164"
			},
			{
				text: "GoogleDeepMind: We're presenting AlphaProteo: an AI system for designing novel proteins that bind more successfully to target molecules. It could help advance drug design and more. #AI #Science",
				url: "https://x.com/GoogleDeepMind/status/1831710991475777823"
			},
			{
				text: "OpenAI: GPT-4o got an update! The model's creative writing ability has leveled up–more natural, engaging, and tailored writing to improve relevance & readability. #AI",
				url: "https://x.com/OpenAI/status/1859296125947347164"
			},
			{
				text: "AnthropicAI: Introducing two new ways to create with Claude: A dedicated space for building, hosting, and sharing artifacts, and the ability to embed AI capabilities directly into your creations. #AI",
				url: "https://x.com/AnthropicAI/status/1937921801000219041"
			},
			{
				text: "MIT_CSAIL: MIT CSAIL, @AIHealthMIT, & @RecursionPharma have released a protein-binding affinity model called Boltz-2 that could expand the role of AI in drug discovery. #AI",
				url: "https://x.com/MIT_CSAIL/status/1930985598283612184"
			},
			{
				text: "StanfordAILab: arXiv to alphaXiv - Students at Stanford have built alphaXiv, an open discussion forum for arXiv papers. You can post questions and comments directly on top of any arXiv paper! #AI",
				url: "https://x.com/StanfordAILab/status/1818669016325800216"
			}
		]

		# Randomly select 6 tweets from the pool
		all_tweets.sample(6)
	end
end