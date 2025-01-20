class SiteColor < ApplicationRecord
  validates :primary, :terciary, :sencondary, :logo_header, :logo_footer, presence: true
  validates_format_of :primary, :terciary, :sencondary, with: /\A#(?:[0-9a-fA-F]{3}){1,2}\z/
  mount_uploader :logo_header, LogoHeaderUploader
  mount_uploader :logo_footer, LogoFooterUploader 

  audited
end