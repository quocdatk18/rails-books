# frozen_string_literal: true

# module ApplicationHelper
module ApplicationHelper
  include Pagy::Frontend

  def show_image(image)
    image.attached? ? image : '/no_image.svg.png'
  end

  def format_date(date)
    date.strftime('%d/%m/%Y')
  end
end
