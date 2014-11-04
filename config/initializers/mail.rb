ActionMailer::Base.smtp_settings = {
    :port =>           '587',
    :address =>        'smtp.mandrillapp.com',
    :user_name =>      ENV['MANDRILL_USERNAME'],
    :password =>       ENV['MANDRILL_PASSWORD'],
    :domain =>         'xbvids.com',
    :authentication => :plain
}
ActionMailer::Base.delivery_method = :smtp
