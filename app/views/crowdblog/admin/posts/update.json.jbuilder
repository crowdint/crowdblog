json.(@post, :state)
json.published_at @post.published_at.try(:to_s, :crowdblog_short)
