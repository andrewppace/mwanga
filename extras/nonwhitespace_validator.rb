class NonwhitespaceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^\S+$/
      record.errors[attribute] << (options[:message] || "must be non-whitespace characters")
    end
  end
end
