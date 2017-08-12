module ApplicationHelper
  def title(content)
    content_tag :h1, content
  end

  def new_model_text(model, femenine=false)
    translation_key = "activerecord.new#{'_femenine' if femenine}"
    t(translation_key, model_name: t("#{model.name.downcase}.one", scope: 'activerecord.models'))
  end

  def edit_model_text(model)
    t('activerecord.edit', model_name: t("#{model.name.downcase}.one", scope: 'activerecord.models'))
  end

  def show_model_text(model_instance, attribute)
    "#{t("#{model_instance.class.name.downcase}.one", scope: 'activerecord.models')} #{model_instance[attribute]}"
  end

  def index_model_text(model)
    t("activerecord.models.#{model.name.downcase}.other")
  end

  def submit_button(f)
    content_tag :div, class: 'col-sm-offset-3 col-sm-9' do
      f.submit class: 'btn btn-primary'
    end
  end

end
