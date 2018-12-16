module ApplicationHelper
  def current_page?(path)
    request.path == path
  end

  def format_number(number)
    number_with_delimiter(number, delimiter: " ")
  end
end
