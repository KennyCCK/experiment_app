class JsonValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    JSON.parse(value) if value
  rescue JSON::ParserError => e
    record.errors[attribute] << (options[:message] || "#{attribute} is not a JSON format")
    record.errors.details[attribute] << { error: :not_a_json }
  end
end
