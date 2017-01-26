class List < ApplicationRecord
  extend CommonScopes

  mount_uploader :attachment, AttachmentUploader

  has_many :subscriptions, dependent: :restrict_with_error
  has_many :leads, -> { merge(Subscription.active) }, through: :subscriptions

  delegate :path, to: :attachment, prefix: true

  def attachment?
    attachment.file.present?
  end

  def to_s
    name
  end
end
