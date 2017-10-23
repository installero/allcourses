module ApplicationHelper
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
end
