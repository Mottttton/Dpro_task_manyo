class Label < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tasks

  validates :name, presence: true

  scope :current_user_labels, -> (user){where(user_id: user.id)}
  scope :with_num_of_tasks, -> () { left_outer_joins(:tasks).select('labels.*, COUNT(tasks.id) AS tasks_count').group('labels.id') }
end
