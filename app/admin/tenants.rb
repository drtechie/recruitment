# frozen_string_literal: true

ActiveAdmin.register Tenant do
  permit_params :name, :config, :domain
  json_editor

  form do |f|
    f.inputs do
      f.input :name
      f.input :domain
      f.input :config, as: :jsonb
    end
    f.actions
  end
end
