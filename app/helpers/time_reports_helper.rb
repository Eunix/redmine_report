module TimeReportsHelper
  # Special helper to color an issue dependeing of its status
  def show_issue_tr(issue_array, day)
    #date = Date.parse(day)
    issue = Issue.find(issue_array[0])
    if issue.closed_date
      if issue.closed_date.to_date > day
        issue_color = "#ffffdd" # yellow (in_process)
      else
        issue_color = "#dfffdf" # green (closed)
      end
    else
      issue_color = "#ffffdd" # yellow (in_process)
    end

    html  = <<HTML
    <tr>
        <td class="issue_name" style="background-color:#{issue_color}">#{issue.subject}</td>
        <td class="spent_time">#{issue_array[1]}</td>
    </tr>
HTML
    html.html_safe
  end
end
