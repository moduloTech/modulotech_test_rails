class AvailabilityValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, _value)
    free_rooms_ids = Room.free_on(record.start_date, record.end_date).pluck(:id)
    record.errors.add(attribute, 'not available') unless free_rooms_ids.include? record.room_id
  end

end
