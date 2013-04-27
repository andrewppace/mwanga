class AlphanumericValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^[a-zA-Z0-9]+$/
      record.errors[attribute] << (options[:message] || "must be only alphanumeric characters")
    end
  end
end
