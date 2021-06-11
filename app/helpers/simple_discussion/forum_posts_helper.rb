module SimpleDiscussion::ForumPostsHelper
  # Override this to use avatars from other places than Gravatar
  def avatar_tag(email)
    image_tag gravatar_url_for(email, size: 40), class: "rounded avatar"
  end

  def category_link(category)
    link_to category.name, simple_discussion.forum_category_forum_threads_path(category),
      style: "color: #{category.color}"
  end

  # Override this method to provide your own content formatting like Markdown
  def formatted_content(text)
    simple_format(text)
  end

  def forum_post_classes(forum_post)
    klasses = ["forum-post", "card", "mb-3"]
    klasses << "solved" if forum_post.solved?
    klasses << "original-poster" if forum_post.user == @forum_thread.user
    klasses
  end

  def forum_user_badge(user)
    if user.respond_to?(:moderator) && user.moderator?
      content_tag :span, "Mod", class: "badge badge-default"
    end
  end

  def gravatar_url_for(email, **options)
    hash = Digest::MD5.hexdigest(email&.downcase || "")
    options.reverse_merge!(default: :mp, rating: :pg, size: 48)
    "https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1617800457/op4ktofumi5snjcw0dxd.jpg"
  end
end
