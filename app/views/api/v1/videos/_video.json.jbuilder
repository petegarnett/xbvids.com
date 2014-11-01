json.id video.id
json.clip_id video.clip_id

json.recorded_at video.recorded_at
json.created_at video.created_at
json.updated_at video.updated_at

json.clip do

  json.video do
    json.high video.cdn_clip_url
    json.medium video.cdn_medium_clip_url
    json.low video.cdn_small_clip_url
  end

  json.thumbnail do
    json.high video.cdn_thumbnail_url
    json.medium ImageHelper.resized(video.cdn_thumbnail_url, 400)
    json.low ImageHelper.resized(video.cdn_thumbnail_url, 150)
  end

  json.why video.clip_type
  json.caption video.caption

  json.is_uploaded video.is_uploaded?
end

json.game do
  json.id (video.game) ? video.game.id : nil
  json.title video.title
  json.image_box (video.game) ? video.game.image_box : nil
end

json.user do
  json.id video.user.id
  json.gamertag video.user.gamertag
end

json.popularity do
  json.likes video.like_count
  json.views video.view_count
end
