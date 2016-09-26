class Attachment < ApplicationRecord
  belongs_to :attachable, optional: true,polymorphic: true
  validates :file, presence:  true
  mount_uploader :file, FileUploader
end
