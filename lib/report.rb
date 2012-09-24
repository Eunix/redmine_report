# encoding: utf-8
class Report
  def self.get(group, week)
    our_field = IssueCustomField.where(name: "Тип задачи").first
    issues = Hash.new

    # People
    group.users.each do |user|
      # Name
      issues[user.name] = {}

      # Spent time
      time_entries = TimeEntry.where(user_id: user.id, tweek: week)

      time_entries.each do |time_entry|
        issue = time_entry.issue

        # Type of issue (from our custom field)
        issue_type = CustomValue.where(customized_type: "Issue", customized_id: issue.id, custom_field_id: our_field.id).first
        if issue_type
          issue_type = issue_type.value
        else
          issue_type = "Неизвестно"
        end

        unless issues[user.name][issue_type]
          issues[user.name][issue_type] = {}
        end

        # Issue info
        if issues[user.name][issue_type][issue.id]
          issues[user.name][issue_type][issue.id] = issues[user.name][issue_type][issue.id] + time_entry.hours
        else
          issues[user.name][issue_type][issue.id] = time_entry.hours
        end
      end
    end

    issues
  end
end