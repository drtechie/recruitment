# frozen_string_literal: true

ActiveAdmin.register User do
  before_create(&:skip_confirmation!)
  permit_params :title, :first_name, :middle_name, :last_name,
                :email, :password, :password_confirmation, :admin

  index do
    selectable_column
    id_column
    column :title
    column :first_name
    column :middle_name
    column :last_name
    column :email
    column :admin
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :first_name
      row :middle_name
      row :last_name
      row :email
      row :admin
      row :created_at
      row :updated_at
    end
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
  filter :admin

  member_action :confirm, method: "get" do
    user = User.find(params[:id])
    user.confirm
    redirect_to admin_user_path(user), notice: "User confirmed!"
  end

  action_item :confirm_user, only: :show do
    link_to("Confirm User", confirm_admin_user_path(user))
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :first_name
      f.input :middle_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :admin
    end
    f.actions
  end
end
