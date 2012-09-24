# encoding: utf-8
class CreateCustomField < ActiveRecord::Migration
  def self.up
    new_field = CustomField.new(
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
    new_field.type = "IssueCustomField"
    new_field.save
  end

  def self.down
    CustomField.where(type: "IssueCustomField", name: "Тип задачи").first.destroy
  end
end