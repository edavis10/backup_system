module ApplicationHelper
  def format_datetime_to_iso(date)
    date.strftime("%Y-%m-%d %H:%M")
  end
end
