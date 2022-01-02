module ApplicationHelper

    def oraganization_name(organization_id)
        Organization.find(organization_id).name
    end
    
      def s3_link(organization_id, item_key)
        link_to item_key, "#{item_key}", class: "main-link", target: 'new'
      end

    ALERT_TYPE = [:success, :info, :warning, :danger] unless const_defined?(:ALERT_TYPES)

    def bootstrap_flash(options = {})
        flash_messages = []
        flash.each do |type, message|
            next if message.blank

            type = type.to_sym
            type = :success if type == :notice
            type = :danger if type == :alert
            type = :danger if type == :error
            
            next unless ALERT_TYPES.include? (type)

            tag_class = options.extract!(:class)[:class]
            tag_options = {
                class: "alert fade in alert-#{type} #{tag_class}"
                }.merge(options)

            close_button = content_tag(:button, raw("&times;"), type: "button", class: "close", "data-dismiss" => "alert")

            Array(message).each do |msg|
                text = content_tag(:div, close_button + msg, tag_options)
                flash_messages << text if msg
            end
        end
        flash_messages.join("\n").html_safe
    end

    def class_name_for_organization_form(organization)
        return "cc_form" if organization.payment.blank?
        ""
    end
end
