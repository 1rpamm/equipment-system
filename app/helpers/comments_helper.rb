# -*- encoding : utf-8 -*-
module CommentsHelper
  def show_comment_body(comment)
    h(comment.body).gsub(/#(#{Tag::FORMAT})/i){|x| raw link_to h(x), show_tag_path(:name => x[1..-1])}.html_safe
  end
end
