class ChangeRequest < ApplicationRecord
  belongs_to :pull_request
  belongs_to :dns_record

  def status
    'success' if pull_request.merged?
    'rejected' if pull_request.closed?
    'pending'
  end
end
