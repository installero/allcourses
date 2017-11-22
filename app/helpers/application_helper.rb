module ApplicationHelper
  RATING_STARS = 5

  def control_class(model, field, original = 'form-control')
    original += ' is-invalid' if model_has_error?(model, field)
    original
  end

  def hint_for(model, field, text = nil)
    if model_has_error?(model, field)
      content_tag(:div, class: 'invalid-feedback') do
        model.errors[field][0]
      end
    else
      content_tag(:small, class: 'form-text text-muted') do
        text
      end
    end
  end

  def model_has_error?(model, field)
    model.try(:errors) && model.errors[field].present?
  end

  def rating_stars_for(rating)
    rating = (rating * 2.0).round / 2.0

    stars = rating.floor.times.map { fa_icon('star') }

    stars << fa_icon('star-half-o') if rating % 1 > 0

    stars += (RATING_STARS - stars.length).times.map { fa_icon('star-o') }

    content_tag 'span', class: 'text-primary' do
      stars.join.html_safe
    end
  end
end
