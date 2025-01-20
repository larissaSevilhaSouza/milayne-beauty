class AuditController < ApplicationController
  def index
    user = current_user
    history = Audit.where('created_at >= ?', 90.days.ago)
                  .order(created_at: :desc)
                  .map do |audit|
                    changes = audit.audited_changes.map do |attribute, (old_value, new_value)|
                      "#{attribute}: #{old_value} -> #{new_value}"
                    end.join("\n")

                    { 
                      I18n.t('audit.user_id') => audit.user_id,
                      I18n.t('audit.user_name') => audit.user&.name, 
                      I18n.t('audit.auditable_type') => audit.auditable_type,
                      I18n.t('audit.action') => audit.action,
                      I18n.t('audit.audited_changes') => changes,
                      I18n.t('audit.created_at') => audit.created_at.in_time_zone('Brasilia').strftime('%d/%m/%Y %H:%M')                    
                    }
                  end
    render json: JSON.pretty_generate(history)
  end
end