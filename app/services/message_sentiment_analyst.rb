class MessageSentimentAnalyst
  SENTIM_API_URL = 'https://sentim-api.herokuapp.com/api/v1/'.freeze

  def initialize(message)
    @message = message
    @response = nil
  end

  def self.call(*args, &block)
    new(*args, &block).call
  end

  def call
    response.is_a?(Net::HTTPSuccess) ? JSON.parse(response.body)['result']['type'] : 'API failed'
  end

  def response
    @response ||= Net::HTTP.post URI(SENTIM_API_URL),
                                 { 'text' => @message }.to_json,
                                 'Content-type' => 'application/json',
                                 'Accept' => 'application/json'
  end
end
