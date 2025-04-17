ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    div class: "dashboard-links" do
      h3 "Quick Links"
      ul do
        li do
          link_to 'Manage Products', admin_products_path
        end
        li do
          link_to 'Manage Categories', admin_categories_path
        end
      end
    end
  end
end
