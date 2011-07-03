# == Schema Information
# Schema version: 20110703034007
#
# Table name: uploads
#
#  id           :integer         not null, primary key
#  project_id   :integer
#  reply_id     :integer
#  asset        :string(255)
#  file_size    :integer
#  content_type :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Upload < ActiveRecord::Base
  belongs_to :project
  belongs_to :reply

  mount_uploader :asset, AssetUploader

  before_save :set_asset_info

  private
    def set_asset_info
      self.content_type = asset.file.content_type
      self.file_size = asset.file.size
    end
end