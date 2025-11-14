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
			"#{tweet.user.screen_name}: #{tweet.text}"
		end
	end

	def self.fallback_tweets
		[
			"OpenAI: Introducing GPT-4 Turbo with enhanced capabilities for AI development. Learn more about the latest features. #AI #MachineLearning",
			"AnthropicAI: Constitutional AI is reshaping how we build safer AI systems. Read our latest research on alignment. #AI #AIResearch",
			"GoogleAI: Google DeepMind announces breakthrough in protein folding predictions using AI. #AI #Science",
			"MIT_CSAIL: New AI model achieves state-of-the-art results in natural language understanding. Check out the paper. #AI #NLP",
			"Stanford_AI: Exploring the future of human-AI collaboration in our latest AI Index Report. #AI #Technology",
			"HuggingFace: New transformer models now available on our platform. Build amazing AI applications today! #AI #OpenSource"
		]
	end
end