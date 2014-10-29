json.id video.id
json.clip_id video.clip_id


json.clip do
  json.video_url "https://s3-eu-west-1.amazonaws.com/xbone-clips/%s.mp4" % [video.clip_id]
  json.thumbnail_url video.thumbnail_large
  json.why video.clip_type
end

json.game do
  json.title video.title
end

json.user do
  json.id video.user.id
  json.gamertag video.user.gamertag
end
