require 'datastore/memory_datastore/models/base'

module Memory
  class Blogpost < Base

    attr_accessor :id, :apprenticeship_id, :week, :title, :url

    def initialize(params = {})
      validate_presence_of(params, :title, :url, :week, :apprenticeship_id)
      @apprenticeship_id = params[:apprenticeship_id].to_i
      @week = params[:week].to_i
      @title = params[:title]
      @url = params[:url]
      set_url
    end

    def set_url
      if @url != nil
        @url = "http://" + url unless @url.include?("http://")
      end
    end

    
    def valid?
      @errors.empty?
    end
  end
end


