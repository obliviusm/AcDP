class Task < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  has_and_belongs_to_many :executors, class_name: "User", join_table: :executing_tasks_executors, 
    foreign_key: :task_id, association_foreign_key: :executor_id
  has_and_belongs_to_many :tags, join_table: :task_has_tags
  has_many :checklists
  accepts_nested_attributes_for :checklists, allow_destroy: true

  STATUS = ["Active", "Frozen", "Done", "Undone"]

  serialize :check_list, Array
end

