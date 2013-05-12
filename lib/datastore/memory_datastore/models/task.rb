require 'tags'
require 'date'
require 'datastore/memory_datastore/models/base'

module Memory
  class Task < Base
    attr_accessor :id, :apprenticeship_id, :week, :title, :note, :points, :tags, :complete

    def initialize(params = {})
      validate_presence_of(params, :title, :apprenticeship_id)
      @apprenticeship_id = params[:apprenticeship_id].to_i
      @week = params[:week].to_i
      @title = params[:title]
      @note = params[:note]
      @points = params[:points].to_f
      @tags = add_tags(params[:tags])
      @complete = true if params[:complete] == "true"
    end

    def valid?
      @errors.empty?
    end

    def update(params)
      @week = params[:week].to_i unless params[:week].nil?
      @title = params[:title] unless params[:title].nil?
      @note = params[:note] unless params[:note].nil?
      @points = params[:points].to_f unless params[:points].nil?
      @complete = true if params[:complete] == "true"
      add_tags(params[:tags]) unless params[:tags].nil?
    end

    def general
      @week == 0 ? true : false
    end 

    def complete?
      @complete == true
    end

    def add_tags(tag_array)
      if tag_array == nil
        @tags = [] 
      else
        @tags = []
        tag_array.each {|tag| @tags << tag.to_i}
        @tags.sort!
      end
    end

    def apprenticeship
      Repository.for(:apprenticeship).find_by_id(@apprenticeship_id)
    end

    def display_tag_names
      return [] if @tags == nil
      names = []
      @tags.each do |tag|
        names << Tags::CATEGORIES[tag]
      end
      names
    end

    def current?
      apprenticeship = Repository.for(:apprenticeship).find_by_id(@apprenticeship_id)
      (Date.today - apprenticeship.weeks[@week]) <= 10
    end

  end
end
