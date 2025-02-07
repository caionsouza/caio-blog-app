class Profile < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :birth, presence: true
  validates :gender, presence: true
  validate :validate_gender
  
  after_create :set_role

  enum role: [:member, :admin, :superadmin]


  private

  def validate_gender
    unless ["Male", "Female"].include?(self.gender)
      errors.add(:gender, "was specified incorrectly")
    end
  end

  def set_role
    if self.role.nil?
      self.update(role: 0)
    end
  end
end
