require "administrate/base_dashboard"

class StudentDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
      gallery: Field::HasOne,
      offers: Field::HasMany.with_options(tab: 'offers'),
      admin_comments: AdminCommentField.with_options(class_name: "Comment"),
      level: Field::BelongsTo,
      id: Field::Number,
      login: Field::String,
      firstname: Field::String,
      lastname: Field::String,
      birthdate: Field::DateTime,
      description: Field::Text,
      gender: Field::String,
      phone_country_code: Field::String,
      phone_number: Field::String,
      type: Field::String,
      first_lesson_free: Field::Boolean,
      occupation: Field::String,
      postulance_accepted: Field::Boolean,
      teacher_status: Field::String,
      email: Field::String,
      encrypted_password: Field::String,
      reset_password_token: Field::String,
      reset_password_sent_at: Field::DateTime,
      remember_created_at: Field::DateTime,
      sign_in_count: Field::Number,
      current_sign_in_at: Field::DateTime,
      last_sign_in_at: Field::DateTime,
      current_sign_in_ip: Field::String,
      last_sign_in_ip: Field::String,
      confirmation_token: Field::String,
      confirmed_at: Field::DateTime,
      confirmation_sent_at: Field::DateTime,
      unconfirmed_email: Field::String,
      failed_attempts: Field::Number,
      unlock_token: Field::String,
      locked_at: Field::DateTime,
      created_at: Field::DateTime,
      updated_at: Field::DateTime,
      admin: Field::Boolean,
      avatar_file_name: Field::String,
      avatar_content_type: Field::String,
      avatar_file_size: Field::Number,
      avatar_updated_at: Field::DateTime,
      mango_id: Field::Number,
      lessons_received: Field::HasMany.with_options(tab: 'received_lessons')
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
      :id,
      :level,
      :email,
      :phone_country_code,
      :phone_number,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
      :id,
      :firstname,
      :lastname,
      :email,
      :birthdate,
      :admin_comments,
      :gender,
      :phone_country_code,
      :phone_number,
      :occupation,
      :mango_id,
      :type,
      :admin,
      :sign_in_count,
      :current_sign_in_at,
      :last_sign_in_at,
      :current_sign_in_ip,
      :last_sign_in_ip,
      :reset_password_sent_at,
      :description,
      :confirmed_at,
      :confirmation_sent_at,
      :unconfirmed_email,
      #:failed_attempts,
      #:unlock_token,
      #:locked_at,
      :created_at,
      :updated_at,
      #:avatar_file_name,
      #:avatar_content_type,
      #:avatar_file_size,
      #:avatar_updated_at,
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
      #:gallery,
      #:offers,
      #:level,
      :login,
      :firstname,
      :lastname,
      :birthdate,
      :description,
      :gender,
      :phone_country_code,
      :phone_number,
      :type,
      :first_lesson_free,
      :occupation,
      #:postulance_accepted,
      :teacher_status,
      :email,
      # :encrypted_password,
      # :reset_password_token,
      # :reset_password_sent_at,
      # :remember_created_at,
      # :sign_in_count,
      # :current_sign_in_at,
      # :last_sign_in_at,
      # :current_sign_in_ip,
      # :last_sign_in_ip,
      # :confirmation_token,
      # :confirmed_at,
      # :confirmation_sent_at,
      # :unconfirmed_email,
      # :failed_attempts,
      # :unlock_token,
      # :locked_at,
      :admin,
  ]

  # Overwrite this method to customize how students are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(student)
  #   "Student ##{student.id}"
  # end
end
