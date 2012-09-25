module TimeReportsHelper
  # Special helper to color an issue dependeing of its status
  def show_issue_tr(issue_array)
    html  = <<HTML
    <tr>
        <td class="issue_name">#{Issue.find(issue_array[0]).subject}</td>
        <td class="spent_time">#{issue_array[1]}</td>
    </tr>
HTML
    html.html_safe
  end
end
