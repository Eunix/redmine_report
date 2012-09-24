# encoding: utf-8
class CreateCustomField < ActiveRecord::Migration
  # Creating new custom field
  def self.up
    new_field = IssueCustomField.create(
        field_format:    "list",
        possible_values:  %w(Заявка Плановая Внеплановая),
        name:             "Тип задачи",
        is_required:      1,
        is_for_all:       1,
        default_value:    "Заявка",
        editable:         1,
        visible:          1,
        multiple:         0
    )

    # Link new custom field with all trackers
    Tracker.all.each do |tracker|
      tracker.custom_fields << new_field
    end
  end

  def self.down
    # Find our field
    our_field = IssueCustomField.where(name: "Тип задачи").first

    # Unlink custom field from trackers
    Tracker.all.each do |tracker|
      tracker.custom_fields.delete(our_field)
    end

    # Destroy field
    our_field.destroy
  end
end