require 'ruby_llm'

RubyLLM.configure do |config|
  config.ollama_api_base = 'http://localhost:11434/v1'
end

module Coach
  class Analyzer
    def initialize(prompt)
      @prompt = prompt
    end

    def analyze_data
      llm = RubyLLM::chat(provider: :ollama, model: 'llama3.1:8b')
      response = llm.ask(@prompt)
      response.content
    end
  end
end
