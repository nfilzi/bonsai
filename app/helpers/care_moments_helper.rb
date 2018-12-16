module CareMomentsHelper
  def care_moment_button_css_class(moment_code)
    custom_css_button =
      case moment_code.to_sym
      when :repot then 'btn-outline-success'
      when :water then 'btn-outline-info'
      when :weed  then 'btn-outline-secondary'
      else "btn-outline-secondary"
      end

    return "care-action btn #{custom_css_button}"
  end

  def care_moment_badge_css_class(moment_code)
    custom_css_badge =
      case moment_code.to_sym
      when :repot then 'badge-success'
      when :water then 'badge-info'
      when :weed  then 'badge-secondary'
      else 'badge-secondary'
      end

    return "care-badge badge #{custom_css_badge}"
  end
end
