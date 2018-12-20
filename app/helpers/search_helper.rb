# NOTE: At some points, this hould move into a Presenter
module SearchHelper
  def active_filter?(filters, filter_name)
    return @filters.keys.include?(filter_name)
  end

  def filter_value_name(filter_name, value)
    name = value['key']

    case filter_name
    when 'age_in_months' then pluralize(name, 'month')
    when 'user_level'    then "Level #{name}"
    else
      name.capitalize
    end
  end

  def human_filter_name(filter_name)
    case filter_name
    when 'age_in_months' then 'Age'
    when 'user_level'    then 'User'
    else
      filter_name.gsub('_', ' ').capitalize
    end
  end

  def sorted_filter_values(filter_name, aggregation)
    values = aggregation['buckets'] || aggregation[filter_name]['buckets']

    if filter_name == 'size'
      sorted_sizes = %w[small medium tall]
      values.sort_by { |value| sorted_sizes.index(value['key']) }
    else
      values.sort_by { |value| value['key'] }
    end
  end
end
