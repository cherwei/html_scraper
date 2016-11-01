class Content < ActiveRecord::Base
  validates :href, presence: true
end
