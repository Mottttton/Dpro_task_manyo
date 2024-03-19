class User < ApplicationRecord
  before_destroy :at_least_one_admin_required, if: :delete_last_admin_user?
  has_many :tasks, dependent: :destroy
  has_many :labels, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i  }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  scope :admin_count, -> () { where(admin: true).count }
  scope :with_tasks_amount, -> () { left_outer_joins(:tasks).select('users.*, COUNT(tasks.id) AS tasks_count').group('users.id') }

  before_update :at_least_one_admin_required, if: :remove_admin_from_last_admin_user?

  private

  def at_least_one_admin_required
    throw :abort
  end

  def remove_admin_from_last_admin_user?
    User.admin_count == 1 && User.find_by(admin: true).id == id && !admin
  end

  def delete_last_admin_user?
    admin? && User.admin_count == 1
  end
end
