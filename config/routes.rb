Rails.application.routes.draw do

  devise_for :users

  resources :users

  #get 'comments/:id/up_vote' => 'comments#up_vote'
  resources :comments do
    member do
      post 'up_vote'
      post 'down_vote'
    end
  end

  resources :comments do
    resources :comments
  end

  post '/languages/:language_id/queries/bing' => "queries#bing_create"
  # namespace :queries do
  #   resources :comments, path: '/:query_id'
  # end

  shallow do
    resources :languages do
      resources :queries do
      # 'lang/:lang_id/queries',           'lang/:lang_id/queries/new',           'queries/:id',      'queries/:id/edit' =>
      #  language_queries_path(@language), new_language_queries_path(@language),  query_path(@query),  edit_query_path(@query)
        resources :comments
        # 'queries/:query_id/comments', 'queries/:query_id/comments/new', 'comments/:id',            'comments/:id/edit' =>
        #  query_comments_path(@query),  new_query_comments_path(@query),  comment_path(@comment),   edit_comment_path(@comment)
      end
    end
  end

  root :to => 'languages#index'
end
