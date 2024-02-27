class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :deadline_on, presence: true
  validates :priority, presence: true
  enum priority: [:low, :middle, :high]
  validates :status, presence: true
  enum status: [:untouched, :undertaking, :completed]

  scope :in_reverse_created_date_order, -> () {order(created_at: "DESC")}
  scope :in_deadline_date_order, -> () {order(deadline_on: "ASC")}
  scope :sorted_by_priority, -> () {order(priority: "DESC")}
  scope :title_search, ->(part) {where("title like ?", "%#{part}%")}
  scope :status_search, ->(status) {where(status: status)}
  scope :title_status_search, -> (part, status) {where("title like ?", "%#{part}%").where(status: status)}
end
