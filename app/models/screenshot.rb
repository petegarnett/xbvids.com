class Screenshot < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  scope :uploaded, -> { where(:is_uploaded => true) }
end
