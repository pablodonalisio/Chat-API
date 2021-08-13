class MessageSentimentAnalyst
  SENTIM_API_URL = 'https://sentim-api.herokuapp.com/api/v1/'.freeze

  def initialize(message)
    @message = message
  end

  def self.call(*args, &block)
    new(*args, &block).call
  end

  def call
    request = Net::HTTP.post URI(SENTIM_API_URL),
                             { 'text' => @message }.to_json,
                             'Content-type' => 'application/json',
                             'Accept' => 'application/json'
    polarity = if request.is_a?(Net::HTTPSuccess)
                 JSON.parse(request.body)['result']['type']
               else
                 'API failed'
               end
  end
end
