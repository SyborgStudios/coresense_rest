module CoresenseRest
  class RequestWrite
    include HTTParty

    def initialize(root, headers, request_class, data)
      @headers = headers
      @root = root
      @request_class = request_class
      @data = data
    end


    def create
      response = HTTParty.post(@root, :body => @data.to_json, :headers => @headers, format: :json)
      raise "#{response.parsed_response.to_s} code: #{response.code}" unless response.code == 201
      RequestRead.new(response.parsed_response['uri'], @headers, @request_class).select
    end

    def update
      response = HTTParty.put(@root, :body => @data.to_json, :headers => @headers, format: :json)
      raise "#{response.parsed_response.to_s} code: #{response.code}" unless response.code == 200
      JSON.parse(response.parsed_response)
    end

    def delete
      response = HTTParty.delete(@root, :body => @data.to_json, :headers => @headers, format: :json)
      raise "#{response.parsed_response.to_s} code: #{response.code}" unless response.code == 200
      JSON.parse(response.parsed_response)
    end

  end
end
