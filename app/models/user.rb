class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i  }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  scope :admin_count, -> () { where(admin: true).count }
  scope :with_tasks_amount, -> () { left_outer_joins(:tasks).select('users.*, COUNT(tasks.id) AS tasks_count').group('users.id') }

  after_update :at_least_one_admin_required
  after_destroy :at_least_one_admin_required

  private

  def at_least_one_admin_required
    if User.admin_count == 0
      redirect_to admin_users_path, notice: t('.no_admin')
      throw :abort
    end
  end
end
