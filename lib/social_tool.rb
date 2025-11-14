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
			# #vibecoding tweets (12 total)
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
			{
				text: "garrytan: For 25% of the Winter 2025 batch, 95% of lines of code are LLM generated. That's not a typo. The age of vibe coding is here. #vibecoding",
				url: "https://x.com/garrytan/status/1897303270311489931"
			},
			{
				text: "vibecodingcom: Vibe coding can get you a job in 2025 #vibecoding",
				url: "https://x.com/vibecodingcom/status/1920632008826392870"
			},
			{
				text: "levelsio: I'm organizing the 2025 Vibe Coding Game Jam. Deadline to enter: 25 March 2025. At least 80% code has to be written by AI. Game has to be accessible on web without any login. #vibecoding",
				url: "https://x.com/levelsio/status/1901660771505021314"
			},
			{
				text: "vibingwithai: You can now generate practical apps using natural language, without writing code. And despite what some skeptics still say, this shift - Vibe Coding- is real. #VibeCoding is here to stay.",
				url: "https://x.com/vibingwithai/status/1943651569582354650"
			},
			{
				text: "hackernoon: Vibe coding lets AI generate code—but skips the skills that make developers indispensable. Learn why shortcuts can ruin careers in 2025 tech. #ai #vibecoding",
				url: "https://x.com/hackernoon/status/1962934851713015972"
			},
			{
				text: "deepakravindran: Today's vibe: ☕ One strong coffee 🎧 Lo-fi beats 💻 Chrome Extension playground. I'm deep in Vibe Coding mode — wiring Groccr straight into the places you already shop. #vibecoding",
				url: "https://x.com/deepakravindran/status/1956209329155268917"
			},
			{
				text: "VinodSharma10x: I'm coding until 4 AM again. Not because I have to. But because AI tools made me fall in love with building again. Built 7 apps + a startup with V0, Bolt, Cursor, Copilot, and Claude Code. #vibecoding",
				url: "https://x.com/VinodSharma10x/status/1970235167068332527"
			},
			{
				text: "swyx: RIP Vibe Coding Feb 2025 - Oct 2025 #vibecoding",
				url: "https://x.com/swyx/status/1975711519506833424"
			},

			# #PromptEngineering tweets (12 total)
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
			{
				text: "AnthropicAI: We've added a new prompt improver to the Anthropic Console. Take an existing prompt and Claude will automatically refine it with prompt engineering techniques. #PromptEngineering",
				url: "https://x.com/AnthropicAI/status/1857108263042502701"
			},
			{
				text: "AnthropicAI: We're excited to host over 200 developers at our London hackathon today! Hackers are learning prompt engineering best practices, and connecting with our technical team. #PromptEngineering",
				url: "https://x.com/AnthropicAI/status/1720883656183460078"
			},
			{
				text: "IntuitMachine: Claude 4.0 System Prompt Strategies (Cheat Sheet). A pattern-oriented reading of the Anthropic Claude system prompt for Agentic AI. #PromptEngineering",
				url: "https://x.com/IntuitMachine/status/1936418825240444970"
			},
			{
				text: "AnthropicAI: New on the Anthropic Engineering Blog: Most developers have heard of prompt engineering. But to get the most out of AI agents, you need context engineering. #PromptEngineering",
				url: "https://x.com/AnthropicAI/status/1973098580060631341"
			},
			{
				text: "AnthropicAI: We're excited to welcome 200 developers to our first-ever Anthropic Hackathon this weekend. Catching a prompt engineering workshop and more! #PromptEngineering",
				url: "https://x.com/AnthropicAI/status/1685382878765703168"
			},
			{
				text: "AnthropicAI: Prompt caching with Claude. Caching lets you instantly fine-tune model responses with longer and more instructive prompts—all while reducing costs by up to 90%. #PromptEngineering",
				url: "https://x.com/AnthropicAI/status/1823751314444021899"
			},
			{
				text: "moritzkremb: Anthropic (Claude) has a really neat tool on their website. It's a prompt optimizer and can turn a simple prompt into an advanced prompt template. I've tested it and it works incredibly well. #PromptEngineering",
				url: "https://x.com/moritzkremb/status/1766850258477482333"
			},
			{
				text: "maxedapps: I got a new course! AI For Developers With GitHub Copilot, Cursor AI & ChatGPT. A course where I share my learnings on how to use AI tools efficiently. #PromptEngineering",
				url: "https://x.com/maxedapps/status/1851292916246847732"
			},

			# #AI tweets (12 total)
			{
				text: "OpenAI: Introducing GPT-4o with enhanced capabilities for AI development. The model's creative writing ability has leveled up–more natural, engaging, and tailored writing. #AI #MachineLearning",
				url: "https://x.com/OpenAI/status/1859296125947347164"
			},
			{
				text: "GoogleDeepMind: We're presenting AlphaProteo: an AI system for designing novel proteins that bind more successfully to target molecules. It could help advance drug design and more. #AI #Science",
				url: "https://x.com/GoogleDeepMind/status/1831710991475777823"
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
			},
			{
				text: "AnthropicAI: Today, we're announcing Claude 3, our next generation of AI models. Claude 3 Opus, Sonnet, and Haiku set new industry benchmarks across reasoning, math, coding, multilingual understanding, and vision. #AI",
				url: "https://x.com/AnthropicAI/status/1764653830468428150"
			},
			{
				text: "UnslothAI: Can a 1-bit or 3-bit quantized model outperform GPT-4.1 or Claude-Opus-4? Yes! DeepSeek-V3.1 can be quantized to just 1-bit or 3-bit, and still beat SOTA models. #AI",
				url: "https://x.com/UnslothAI/status/1965797776387879378"
			},
			{
				text: "paulgauthier: The new gpt-4o-2024-11-20 scored the same as the 08-06 version on aider's code editing benchmark. This may be the first OpenAI in-family model update that wasn't actually worse. #AI",
				url: "https://x.com/paulgauthier/status/1859320459634016553"
			},
			{
				text: "taratan: Bytedance just shipped an AI IDE called Trae— a coding assistant like Github Copilot, Cursor. It seems like you can go from design to code by uploading a screenshot to the chat. #AI",
				url: "https://x.com/taratan/status/1882467215200698386"
			},
			{
				text: "andrewbrown: AI-Coding-Assistant Tools Ranked: #1 Windsurf Codeium - Just works, even if you don't use any of the additional features. I don't have to learn any hotkeys, I just go. #AI",
				url: "https://x.com/andrewbrown/status/1886845189274382553"
			},
			{
				text: "WesRothMoney: Microsoft is planning a major overhaul of GitHub to defend against rising competition from AI coding tools like Cursor and Claude Code. Making Copilot available across all developer environments. #AI",
				url: "https://x.com/WesRothMoney/status/1977343744006386043"
			},
			{
				text: "dogudenizugur: Cursor vs. VS Code CoPilot - Which one should you choose? Inline Completion: Cursor > VS Code. Cursor's completion is faster, going better with my flow, and broader. #AI",
				url: "https://x.com/dogudenizugur/status/1884828889815687416"
			}
		]

		# Randomly select 6 tweets from the pool of 36
		all_tweets.sample(6)
	end
end