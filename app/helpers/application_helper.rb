module ApplicationHelper

    def oraganization_name(organization_id)
        Organization.find(organization_id).name
    end
    
      def s3_link(organization_id, item_key)
        link_to item_key, "#{item_key}", class: "main-link", target: 'new'
      end

end
