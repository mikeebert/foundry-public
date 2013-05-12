class TagHelper
  def self.format_tags(tag_array)
    tags = []
    tag_array.each {|tag| tags << tag.to_i}
    tags.sort!
  end
end
