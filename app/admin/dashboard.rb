ActiveAdmin.register_page "Dashboard" do
  menu priority: 1

  content do
    columns do
      column do
        panel "Recent subscriptions" do
          table_for Subscription.newer(10) do
            column(:list) { |subscription| subscription.list_name }
            column(:lead) { |subscription| link_to subscription.lead_email, admin_subscription_path(subscription) }
            column(:status) { |subscription| status_tag(subscription.status) }
          end

          text_node link_to("View all", admin_subscriptions_path)
        end
      end

      column do
        panel "Recent leads" do
          table_for Lead.newer(10) do
            column(:name) { |lead| lead.name }
            column(:email) { |lead| link_to lead.email, admin_lead_path(lead) }
          end

          text_node link_to("View all", admin_leads_path)
        end
      end

      column do
        panel "Recent lists" do
          table_for List.newer(10) do
            column(:name) { |list| link_to list.name, admin_list_path(list) }
            column(:members) { |list| list.leads.count }
          end

          text_node link_to("View all", admin_lists_path)
        end
      end
    end
  end
end
