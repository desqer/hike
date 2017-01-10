ActiveAdmin.register List do
  menu priority: 4

  filter :name
  filter :created_at

  index do
    column(:name)
    column(:id)
    column(:created_at)

    actions
  end
end
