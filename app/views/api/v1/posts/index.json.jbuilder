json.array! @posts do |post|
  json.id post.id
  json.body post.body
  json.photo post.photo
  json.url post.url
end