module ApplicationHelper
  def single_location_map_link(address)
    "https://maps.google.com/maps/api/staticmap?size=320x240&
    sensor=false&zoom=12&markers=#{address}"
  end

  def options_for_categories
    options_for_select(
      Category.all.map { |category| [category.name, category.id] }
    )
  end

  def options_for_sight_ratings(selected = nil)
    options_for_select(rating_values_list, selected)
  end

  private

  def rating_values_list
    [5, 4, 3, 2, 1].map { |number| [pluralize(number, "Star"), number] }
  end
end
