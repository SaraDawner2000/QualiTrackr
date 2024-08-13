module Cleanable
  extend ActiveSupport::Concern

  included do
    def delete_empty_params(params)
      params.delete_if { |key, value| value == "" }
    end

    def purge_attachment(record, attachment_name, attachment_description)
      record.send(attachment_name).purge
      notice_message = record.send(attachment_name).attached? ? "Failed to remove #{attachment_description}" : "#{attachment_description.humanize} successfully removed"
      redirect_to edit_quality_project_url(record), notice: notice_message
    end
  end

  class_methods do
  end
end
