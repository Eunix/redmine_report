# encoding: utf-8
class Report
  def self.get(group_id, week)
    group = Group.find(group_id)
    our_field = IssueCustomField.where(name: "Тип задачи").first
    report = Array.new
    week_begin = Date.commercial(2012, week.to_i, 1)
    week_end = Date.commercial(2012, week.to_i, 5)

    # People
    group.users.each do |user|
      # Spent time
      days = {}

      (week_begin..week_end).each do |day|
        time_entries = TimeEntry.where(user_id: user.id, spent_on: day)

        # Issues
        issues = {}

        time_entries.each do |time_entry|
          issue = time_entry.issue

          # Type of issue (from our custom field)
          issue_type = CustomValue.where(customized_type: "Issue", customized_id: issue.id, custom_field_id: our_field.id).first
          if issue_type
            issue_type = issue_type.value
          else
            issue_type = "Неизвестно"
          end

          unless issues[issue_type]
            issues[issue_type] = {}
          end

          # Issue info
          if issues[issue_type][issue.id]
            issues[issue_type][issue.id] = issues[issue_type][issue.id] + time_entry.hours
          else
            issues[issue_type][issue.id] = time_entry.hours
          end
        end

        days[day] = issues
      end

      report << {
          :user_name => user.name,
          :days => days
      }
    end

    report
  end
end