ActiveAdmin.register_page "Dashboard" do

  menu priority: 1

  content do
    columns do
      column do
        panel "Recent leads" do
          ul do
            Lead.newer(10).map do |lead|
              li link_to(lead.name, admin_lead_path(lead))
            end
          end
        end
      end

      column do
        panel "Recent subscriptions" do
          ul do
            Subscription.newer(10).map do |subscription|
              li link_to("#{subscription.lead} on #{subscription.list}", admin_subscription_path(subscription))
            end
          end
        end
      end

      column do
        panel "Recent lists" do
          ul do
            List.newer(10).map do |list|
              li link_to(list.name, admin_list_path(list))
            end
          end
        end
      end
    end
  end
end
