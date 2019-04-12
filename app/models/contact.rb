class Contact < ApplicationRecord
  validates :first_name, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true
  validates :bio, presence: true
  validates :bio, length:{in: 10..1000}
  validates :last_name, presence: true
  validates :email, uniqueness: true
  validates :phone_number, uniqueness: true
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :phone_number, format: { with: /\d{3}-\d{3}-\d{4}/, message: "bad format" }
  
belongs_to :user

  def friendly_updated_at
    updated_at.strftime("%B %e, %Y")
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def japanese_prefix
    q = 12
    e = 23
    "+81 #{phone_number}"
  end
end
