require 'date'
require 'datastore/memory_datastore/models/base'

module Memory
  class Feedback < Base
    attr_accessor :apprenticeship_id, :author_id,
      :id, :week, :created_at,
      :rating, :good, :improve, :change

    def initialize(params = {})
      validate_presence_of(params, :rating, :week, :apprenticeship_id, :author_id, :good, :improve, :change)
      @apprenticeship_id = params[:apprenticeship_id].to_i
      @author_id = params[:author_id].to_i
      @week = params[:week].to_i
      @rating = params[:rating].to_i
      @good = params[:good]
      @improve = params[:improve]
      @change = params[:change]
      @created_at = Date.today
    end

    def author
      Repository.for(:user).find_by_id(@author_id)
    end

    def valid?
      @errors.empty?
    end
  end
end
