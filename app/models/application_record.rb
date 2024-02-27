class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.human_attribute_enum_value(attr_name, value)
    return if value.blank?
    human_attribute_name("#{attr_name}.#{value}")
  end

  def self.enum_options_for_select(attr_name)
    self.send(attr_name.to_s.pluralize).map { |k, _| [self.human_attribute_enum_value(attr_name, k), k] }
  end
end
