class Screenshot < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  scope :uploaded, -> { where(:is_uploaded => true) }

  def cdn_url
    return "https://dcw5p6q8lhu7t.cloudfront.net/%s" % [xuid]
  end
end
