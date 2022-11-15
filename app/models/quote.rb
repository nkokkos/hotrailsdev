class Quote < ApplicationRecord
  belongs_to :company

  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) }

  #after_create_commit -> { broadcast_prepend_to "quotes", partial: "quotes/quote",
  #                                               locals: {quote: self}, target: "quotes" }
  #the above line can be replaced by:
  #after_create_commit -> { broadcast_prepend_to "quotes" }
  
  #after_update_commit ->  { broadcast_replace_to "quotes" }
  #after_destroy_commit -> { broadcast_remove_to  "quotes" }

  # broadcasting asynchronous with activejob
  after_create_commit  ->  { broadcast_prepend_to "quotes" }
  after_update_commit  ->  { broadcast_replace_to "quotes" }
  after_destroy_commit ->  { broadcast_remove_to  "quotes" }

  # while running fixtures test, rails has problems deleting foreigh keys:
  # use this to fix it on database development server
  # https://stackoverflow.com/questions/30729723/ruby-on-rails-deleting-fixtures-with-foreign-keys
 
end
