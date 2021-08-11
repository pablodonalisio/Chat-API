class MessageSentimentAnalyst
  def initialize(message)
    @message = message
  end

  def self.call(*args, &block)
    new(*args, &block).call
  end

  def call
    request = Net::HTTP.post URI('https://sentim-api.herokuapp.com/api/v1/'),
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
