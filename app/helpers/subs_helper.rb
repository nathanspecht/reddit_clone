module SubsHelper

  def is_moderator?
    current_user.id == @sub.moderator_id
  end


end
