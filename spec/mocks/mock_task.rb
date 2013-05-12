require 'mocks/mock_apprenticeship'

class MockTask
  attr_accessor :id, :apprenticeship_id, :week, :title, :note, :points, :general, :tags, :complete
  
  def initialize(params = {})
    @apprenticeship_id = params[:apprenticeship_id]
    @week = params[:week]
    @title = params[:title]
    @note = params[:note]
    @points = params[:points]
    @general = params[:general] || false
    @tags = []
    @complete = false
  end

  def apprenticeship
    return MockApprenticeship.new
  end

  def save
    
  end

  def display_tag_names
    []
  end

  def complete?
    
  end
end
