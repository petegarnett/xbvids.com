json.id video.id
json.clip_id video.clip_id

json.recorded_at video.recorded_at

json.clip do
  json.video_url "https://s3-eu-west-1.amazonaws.com/xbone-clips/%s.mp4" % [video.clip_id]
  json.thumbnail_url "https://s3-eu-west-1.amazonaws.com/xbone-thumbnails/%s.png" % [video.clip_id]
  json.why video.clip_type
  json.is_uploaded video.is_uploaded
end

json.game do
  json.title video.title
end

json.user do
  json.id video.user.id
  json.gamertag video.user.gamertag
end
