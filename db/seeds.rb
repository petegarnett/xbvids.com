# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = [
  {
    :id => 1,
    :email => 'nick@nicksays.co.uk',
    :password => 'password1',
    :password_confirmation => 'password1',
    :gamertag => 'Mr Punkstar',
    :xuid => '2669991207663180'
  }
]

videos = [
  {
    id: 1,
    clip_id: "e5256d3c-2d79-419b-9f8c-9995450235df",
    recorded_at: "2014-10-26 09:55:32",
    clip_type: "DeveloperInitiated",
    thumbnail_large: "http://gameclipscontent-t2009.xboxlive.com/00097c57c57c764c-e5256d3c-2d79-419b-9f8c-9995450235df/Thumbnail_Large.PNG",
    source_uri: "ttp://gameclipscontent-d2009.xboxlive.com/asset-35d75cac-a9d1-44b4-b609-35cd399ef427/GameClip-Original.MP4?sv=2012-02-12&st=2014-10-27T23%3A05%3A55Z&se=2014-10-28T00%3A10%3A55Z&sr=c&sp=r&sig=DOpBcVMgvPf1fslc%2BWP04BggL1YUEJRZIlavPUQm5RE%3D&__gda__=1414455055_a14d6cbdadbdf5bb25030f73fc65f1d3",
    title: "FIFA 14",
    user_id: 1,
    is_thumbnail_uploaded: true,
    is_clip_uploaded: true,
    game_id: 1
  }
]

games = [
  {
    :id => 1,
    :xgid => 'f04f7029-01ea-4d65-988b-56f583fb7f6c',
    :name => 'FIFA 14',
    :description => 'Fuelled by EA SPORTS IGNITE, FIFA 14 will feel alive with players who move and behave like world-class footballers. Players have four times the decision making ability and feel alive with human-like reactions, anticipation, and instincts. FIFA 14 delivers the dynamic movements and biomechanics of the world’s best footballers. Players are agile and athletic as they plant, pivot, cut and explode out of each step. The increased fidelity has a game-changing effect on gameplay. Plus, the artistry and athleticism of footballers will come to life with the addition of hundreds of new types of skills and hundreds of new behaviors. And for the first time ever, fans will feel the electricity of a living stadium as the emotions of new 3D crowds rise and fall around the stories on the pitch.\\n\\nThe downloadable version of this game supports English, French, Italian, German, Spanish, Dutch.',
    :developer => 'EA Canada',
    :image_box => 'https://dlassets-ssl.xboxlive.com/public/content/f04f7029-01ea-4d65-988b-56f583fb7f6c/74e8aee2-f7c7-4c04-a481-01c2fb662c28/8fac5867-1738-4a40-8ec5-dff2e7a5a1a0.png',
    :image_hero_title => 'https://dlassets-ssl.xboxlive.com/public/content/f04f7029-01ea-4d65-988b-56f583fb7f6c/d56049df-6f72-4364-860b-57460a2066d6/5597c804-4f1e-45e9-b219-52af7e948e3b.png',
    :image_hero_super => 'https://dlassets-ssl.xboxlive.com/public/content/f04f7029-01ea-4d65-988b-56f583fb7f6c/a7bf4f12-bdcd-4740-abde-e353fb14b263/3e935ff6-021f-4630-8146-801b655574a8.png',
    :rating => 80,
    :title_id => '1813362885'
  }
]

puts "Users"
users.each do |data|
  record = User.find_by_id(data[:id])

  if record.nil?
    User.create(data)
    puts "Created #%s" % [data[:id]]
  else
    record.update_attributes(data)
    puts "Updated #%s" % [data[:id]]
  end
end

puts "Videos"
videos.each do |data|
  record = Video.find_by_id(data[:id])

  if record.nil?
    Video.create(data)
    puts "Created #%s" % [data[:id]]
  else
    record.update_attributes(data)
    puts "Updated #%s" % [data[:id]]
  end
end

puts "Games"
games.each do |data|
  record = Game.find_by_id(data[:id])

  if record.nil?
    Game.create(data)
    puts "Created #%s" % [data[:id]]
  else
    record.update_attributes(data)
    puts "Updated #%s" % [data[:id]]
  end
end
