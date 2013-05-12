module Memory
  class Base

    attr_accessor :errors

    def validate_presence_of(params, *required_attributes)
      @errors = {}
      required_attributes.each do |attr|
        @errors[attr] = "#{attr.to_s.capitalize} is required" if blank(params[attr])
      end
    end

    def valid?
      @errors.empty?
    end

    def blank(params)
      params.nil? || params == ""
    end
  end
end
