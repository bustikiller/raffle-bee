module ApplicationHelper
  def title(content)
    content_tag :h1, content
  end

  def new_model_text(model, femenine=false)
    translation_key = "activerecord.new#{'_femenine' if femenine}"
    t(translation_key, model_name: t(model.name.downcase, scope: 'activerecord.models'))
  end

  def panel_with_body(*args)
    panel(*args) do
      content_tag :div, class: 'panel-body' do
        yield
      end
    end
  end
end
