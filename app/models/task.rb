class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :deadline_on, presence: true
  validates :priority, presence: true
  enum priority: [:低, :中, :高]
  validates :status, presence: true
  enum status: [:未着手, :着手中, :完了]

  scope :in_reverse_created_date_order, -> () {order(created_at: "DESC")}
  scope :title_search, ->(part) {where("title like ?", "%#{part}%")}
  scope :status_search, ->(status) {where(status: status)}
  scope :title_status_search, -> (part, status) {where("title like ?", "%#{part}%").where(status: status)}
end
