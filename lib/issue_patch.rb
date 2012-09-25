require_dependency 'issue'

# Patches Redmine's Issues dynamically
module IssuePatch
  def self.included(base) # :nodoc:
    base.extend(ClassMethods)

    base.send(:include, InstanceMethods)

    base.class_eval do
      unloadable
    end

  end

  module ClassMethods

  end

  module InstanceMethods
    # Attemot to find closed date
    def closed_date
      if self.status.is_closed?
        # Search last change to closed status in journal
        JournalDetail.
            joins(:journal => :issue).
            where(
              "`issues`.id = ? AND `journal_details`.prop_key = 'status_id' AND value IN (?)",
              4,
              IssueStatus.where(is_closed: true).map(&:id)
            ).
            order("`journals`.created_on DESC").first.journal.
            created_on
      else
        nil
      end
    end
  end
end

# Add module to Issue
Issue.send(:include, IssuePatch)