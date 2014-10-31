json.id video.id
json.clip_id video.clip_id

json.recorded_at video.recorded_at

json.clip do
  json.video_url video.cdn_clip_url
  json.large_thumbnail_url video.cdn_thumbnail_url
  json.small_thumbnail_url video.cdn_thumbnail_url
  json.why video.clip_type
  json.is_uploaded video.is_uploaded?
end

json.game do
  json.title video.title
  json.image_box (video.game) ? video.game.image_box : nil
end

json.user do
  json.id video.user.id
  json.gamertag video.user.gamertag
end
