module JsHelpers
  def js_set_date(selector, value = '')
    js_set_field selector, value
  end

  def js_set_field(selector, value = '')
    find selector
    page.execute_script("$('#{selector}').val('#{value}')")
  end

  def toggle_optional_input_for(attr)
    js_click ".optional-input-activator-container.#{attr} .optional-input-activator-toggle"
  end

  def toggle_optional_text_field_for(attr)
    js_click ".optional-text-field-activator-container.#{attr} .optional-input-activator-toggle"
  end

  def set_optional_value(attr, value='')
    selector = ".optional-attribute-container.#{attr} input"
    find selector
    js_set_field selector, value
  end

  # Activate the boolean checkbox
  def toggle_optional_boolean_activator_for(attr)
    js_click ".optional-attribute-container.optional-boolean.#{attr} .optional-boolean-activator-toggle"
  end

  # Check the boolean checkbox
  def toggle_optional_boolean_for(attr)
    selector = ".optional-attribute-container.optional-boolean.#{attr} .optional-boolean-toggle"
    js_click selector
  end

  # Trigger a click event through javascript. Use this to avoid waiting for
  # javascript events issues
  def js_click(selector)
    find(selector) # wait for the page to contain the selector
    page.execute_script("$('#{selector}').click()")

    # wait for triggered ajax requests to be finished
    steps = 0
    while page.evaluate_script('$.active').to_i > 0 and steps < 25
      sleep 0.1
      steps += 1
    end
  end

  def expect_path_bo_be(path)
    steps = 0
    while page.current_path != path and steps < 15
      sleep 0.1
      steps += 1
    end
    expect( page.current_path ).to eq path
  end

  # Wait for the database to have finished the update stuff, then reload
  # the models. Threading might give inconsistent data
  def reload_model(*models)
    models.each &:reload
  end
  alias_method :reload_models, :reload_model
end

