# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      # auth
      post "auth/login", to: "auth#login"
      delete "auth/logout", to: "auth#logout"
      get "auth/whoami", to: "auth#whoami"

      # attempts
      get "attempts", to: "attempts#index"
      get "attempts/:attempt_id", to: "attempts#show"
      post "attempts/start", to: "attempts#start"
      post "attempts/next-question", to: "attempts#next_question"
      post "attempts/submit-answer", to: "attempts#submit_answer"
      get "questions/preview/:question_id", to: "questions#preview"
    end
  end
  root to: "home#index"
  get "*path", to: "home#index", format: "html"
end
