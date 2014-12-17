class Invoice < ActiveRecord::Base
  belongs_to :instructor

  attr_accessible :amount, :name, :notes, :submitted_at
end
