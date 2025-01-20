class Adsense < ApplicationRecord
  audited

  validates :title, :ad_type, :script, presence: true

  enum ad_type: {
    "Cabeçalho(Head)": 0,
    "Body": 1,
    "Rodapé(Footer)": 2    
  }
end
