module ApplicationHelper
  def gordon # like flash gordon, duh
    @flash = flash[0] if flash
  end
end
