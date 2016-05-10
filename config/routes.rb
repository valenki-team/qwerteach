Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :galleries
    resources :levels
    resources :pictures
    resources :students
    resources :teachers
    resources :postulations
    resources :comments
    #resources :conversations
    #resources :messages
    #resources :receipts
    get "/user_conversation/:id", to: "users#show_conversation", as: 'show_conversation'

    # Gestion des serveurs BBB depuis l'admin
    resources :bigbluebutton_servers

    root to: "users#index"
  end


  scope '/user/mangopay', controller: :payments do
    get "make_transfert" => :make_transfert
    put "make_transfert" => :send_make_transfert
  end

  scope '/user/mangopay', controller: :wallets do
    get "edit_wallet" => :edit_mangopay_wallet
    put "edit_wallet" => :update_mangopay_wallet
    get "index_wallet" => :index_mangopay_wallet  
    get "direct_debit" => :direct_debit_mangopay_wallet
    put "direct_debit" => :send_direct_debit_mangopay_wallet
    get "transactions" => :transactions_mangopay_wallet
    get "card_info" => :card_info
    put "send_card_info" => :send_card_info
  end

  devise_for :users, :controllers => {:registrations => "registrations"}
  as :user do
    get 'users/edit_pwd' => 'registrations#pwd_edit', :as => 'edit_pwd_user_registration'
  end
  resources :users, :only => [:show, :index] do
    resources :require_lesson
    resources :reviews
  end
  authenticated :user do
    root 'pages#index'
  end

  unauthenticated :user do
    devise_scope :user do
      get "/" => "pages#index"
    end
  end
  resources :galleries, only: [:update, :edit, :show]
  resources :pictures, only: [:new, :destroy, :show]
  resources :degrees
  resources :notifications
  get "/notifications/unread/" => "notifications#number_of_unread"

  resources :adverts do
    resources :advert_prices
  end

  get '/adverts_user/:user_id', to: 'adverts#get_all_adverts', as: 'get_all_adverts'

  get "/pages/*page" => "pages#show"

  resources :become_teacher
  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
      post :mark_as_read
    end
  end
  
  #Permet affichage facture
    get "/payments/index" => "payments#index"


  #post "lessons/:teacher_id/require_lesson", to: "lessons#require_lesson", as: 'require_lesson'
  resources :lessons do
    resources :payments
    post "create_postpayment" => "payments#create_postpayment"
    get "edit_postpayment/:payment_id" => "payments#edit_postpayment", as: 'edit_postpayment'
    post "edit_postpayment/:payment_id" => "payments#send_edit_postpayment", as: 'send_edit_postpayment'

    post "bloquerpayment" => "payments#bloquerpayment"

  end

  resources :messages, only: [:new, :create]
  post "/typing" => "messages#typing"
  post "/seen" => "messages#seen"
  get "/level_choice" => "adverts#choice"
  get "/topic_choice" => "adverts#choice_group"
  post "conversation/show_min" => "conversations#find"
  get "conversation/show_min/:conversation_id" => "conversations#show_min"

  # BBB rooms et recordings
  bigbluebutton_routes :default, :only => 'rooms', :controllers => {:rooms => 'bbb_rooms'}
  resource :bbb_rooms do
    get "/room_invite/:user_id" => "bbb_rooms#room_invite", as: 'room_invite'
  end
  bigbluebutton_routes :default, :only => 'recordings', :controllers => {:rooms => 'bbb_recordings'}

  mount Resque::Server, :at => "/resque"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end


  #root to: 'pages#index'
end
