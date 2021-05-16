module TweetsHelper
  def render_hashtag(content)
    content.gsub(/#\w+/) { |w| link_to w, "tweets?q%5Bcontent_cont%5D=#{w.delete('#')}&commit=Search" }.html_safe
  end
end
