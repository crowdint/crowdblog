module  CrowdblogCore
  class Asset < ActiveRecord::Base
    self.table_name = :assets
    belongs_to :post

    mount_uploader :attachment, AttachmentUploader
  end
end
