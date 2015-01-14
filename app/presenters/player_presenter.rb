class PlayerPresenter < SimpleDelegator

  def player
    __getobj__
  end

  def full_name
    if player.last_name.present? && player.first_name.present?
      "#{player.first_name} #{player.last_name}"
    elsif player.last_name.present?
      "#{player.last_name}"
    elsif player.first_name.present?
      "#{player.first_name}"
    else
      "no name"
    end
  end

  def age
    Date.today.year - player.date_of_birth.year if player.date_of_birth.present?
  end
end
