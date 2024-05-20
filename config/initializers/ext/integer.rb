class Integer
  def to_am_pm
    Time.at(self).utc.strftime("%I:%M %p")
  end
end
