module ApplicationHelper
  def single_location_map_link(address)
    "https://maps.google.com/maps/api/staticmap?size=640x480&sensor=false&zoom=16&markers=#{address}"
  end

  def options_for_categories
    options_for_select(
      Category.all.map{ |category| [category.name, category.id] }
    )
  end
end
