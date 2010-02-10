class LabeledFormBuilder < ActionView::Helpers::FormBuilder
  %w[text_field collection_select password_field text_area select date_select].each do |method_name|
    define_method(method_name) do |field_name, *args|
      #options = args.extract_options!
      options = args.detect {|argument| argument.is_a?(Hash)} || {}
      hint = (options[:hint]) ? @template.content_tag(:small, options[:hint]) : ''
      label_value = (options[:no_label]) ? false : field_label(field_name, *args)
      
      locals = {
        :element => super,
        :options => options,
        :label   => label_value,
        :error   => field_error(field_name)
      }

        
      @template.render :partial => 'forms/field', :locals  => locals
                    
      #@template.content_tag(:div, @template.content_tag(:p, field_label(field_name, *args)  + super + hint ), :class => "clearfix")
    end
  end

  

  def check_box(field_name, *args)
    @template.content_tag(:div, super + " " + field_label(field_name, *args) + field_error(field_name), :class => "clearfix checkbox_wrap")
  end
  
  def radio_button(field_name, *args)
    @template.content_tag(:div, super + " " + field_label(field_name, *args) + field_error(field_name), :class => "clearfix radio_wrap")
  end
  
  def submit(value=nil, *args)
    options = args.detect {|argument| argument.is_a?(Hash)} || {}
    locals = {
      :element => super(value),
      :options => options
    }
    @template.render :partial => 'forms/submit', :locals  => locals
    #@template.content_tag(:div, super, :class => 'submit')
  end
  
  def many_check_boxes(name, subobjects, id_method, name_method, options = {})
    @template.content_tag(:p) do
      field_name = "#{object_name}[#{name}][]"
      subobjects.map do |subobject|
        @template.check_box_tag(field_name, subobject.send(id_method), object.send(name).include?(subobject.send(id_method))) + " " + subobject.send(name_method)
      end.join("<br />") + @template.hidden_field_tag(field_name, "")
    end
  end
  
  def error_messages(*args)
    @template.render_error_messages(object, *args)
  end
  
  private
  def field_label(field_name, *args)
    options = args.extract_options!
    #options.reverse_merge!(:required => field_required?(field_name))
    #options[:label_class] = "required" if options[:required]
    label_class = options[:label_class].blank? ? "" : options[:label_class]
    options[:label_class] =  label_class + " required" if options[:required]
    options.reverse_merge!(:label_class => options[:class]) if options[:class] == 'inline'
    label(field_name, options[:label], :class => options[:label_class])
  end
  
  def field_required?(field_name)
    object.class.reflect_on_validations_for(field_name).map(&:macro).include?(:validates_presence_of)
  end

  def field_error(field_name)
    return if object.nil?
    if object.errors.invalid? field_name
      @template.content_tag(:span, [object.errors.on(field_name)].flatten.first.sub(/^\^/,''), :class => 'error_message')
    else
      ''
    end
  end

end