class HappeningValidator < ActiveModel::Validator
  def validate(record)    
    record.errors[:currency] << "cannot be blank" if record.currency.blank? && !record.cost.blank?
  end
end
