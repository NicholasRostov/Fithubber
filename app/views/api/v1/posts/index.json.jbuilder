json.array! @posts do |post|
  json.id post.id
  json.body post.body
  json.photo post.photo
  json.url post.url
  json.created_at post.created_at.strftime("%b %e, %l:%M %p")
end