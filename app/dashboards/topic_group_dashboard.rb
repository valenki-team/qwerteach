require "administrate/base_dashboard"

class TopicGroupDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    topics: Field::HasMany,
    lessons: Field::HasMany,
    id: Field::Number,
    title: Field::String,
    level_code: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :topics,
    :lessons,
    :id,
    :title,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :topics,
    :lessons,
    :id,
    :title,
    :level_code,
    :created_at,
    :updated_at,
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :topics,
    :lessons,
    :title,
    :level_code,
  ]

  # Overwrite this method to customize how topic groups are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(topic_group)
    "#{topic_group.title}"
  end
end