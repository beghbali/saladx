module ApplicationHelper
  def hexcolor(text)
    Digest::MD5.hexdigest(text).last(6)
  end
end
