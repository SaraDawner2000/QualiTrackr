class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  validates :email, :password, :username, :role, presence: :true

  enum role_options: { quality_manager: "quality_manager", quality_admin: "quality_admin", qc_tech: "qc_tech", prod_manager: "prod_manager" }
end
