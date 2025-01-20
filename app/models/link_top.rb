class LinkTop < ApplicationRecord
  mount_uploader :icon, IconLinkTopUploader
  audited
end
