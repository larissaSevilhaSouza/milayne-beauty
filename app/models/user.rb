class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  audited
    
  validates :name, :email, presence: true
  validates :password, :password_confirmation, presence: true, on: :create
  
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  validate :password_complexity, if: -> { password.present? }

  def password_complexity
    if password.present? and not password.match(/^(?=.*[A-Z])(?=.*\W)(?=.*[0-9]).{12,}$/)
      errors.add :password, "Deve ter no mínimo 12 caracteres, além de incluir ao menos uma letra maiúscula, um caractere especial e um número."
    end
  end

  def update_without_password(params, *options)
    params.delete(:password)
    params.delete(:password_confirmation)

    result = update(params, *options)
    clean_up_passwords
    result
  end
end