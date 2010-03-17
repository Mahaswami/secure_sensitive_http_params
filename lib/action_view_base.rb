class ActionView::Base
    include CryptUtil
    alias_method :select_before_encryption, :select
    def select(object, method, choices, options = {}, html_options = {})
        if matches_pattern?(method.to_s)
            new_object = object
            unless object.respond_to?(method)
                new_object = instance_variable_get("@#{object}")
            end
            value = new_object.send(method)
            options[:selected] = encrypt(value)
            choices = choices.collect{|choice|
                choice[1] = choice[1].blank? ? choice[1] : encrypt(choice[1])
                choice
            }
        end
        select_before_encryption(object, method, choices, options, html_options)
    end
end
