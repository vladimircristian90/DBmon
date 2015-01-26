DBMON::Application.routes.draw do
  resources :users

  get "home/index"
  get "objects/index"
  get "databases/index"
  get "events/index"

  match '/tableDetails' => 'objects#tableDetails';
  match '/tableIndexDetails' => 'objects#tableIndexDetails';
  match '/viewsDetails' => 'objects#viewsDetails';
  match '/proceduresDetails' => 'objects#proceduresDetails';
  match '/triggersDetails' => 'objects#triggersDetails';
  match '/functionsDetails' => 'objects#functionsDetails';
  
  match '/rebuildIndex' => 'requests#rebuildIndex';
  match '/getIndexTable' => 'requests#getIndexTable';
  match '/getDrives' => 'requests#getDrives';
  match '/getDirTree' => 'requests#getDirTree';
  match '/getDatabaseById' => 'requests#getDatabaseById';
  match '/backupDatabase' => 'requests#backupDatabase';
  match '/getRunningProcessesTable' => 'requests#getRunningProcessesTable';


  match '/databaseFiles' => 'databases#files'
  match '/databaseFilegroups' => 'databases#filegroups'
  match '/databaseSize' => 'databases#databaseSize'
  match '/databaseBackup' => 'databases#databaseBackup'
  match '/backupHistory' => 'databases#backupHistory'

  match '/allErrors' => 'events#allErrors'
  match '/allErrorsByType' => 'events#allErrorsByType'
  match '/deadlocks' => 'events#deadlocks'
  match '/runningProcesses' => 'events#runningProcesses'
  match '/sqlServerLog' => 'events#sqlServerLog'
  match '/statementLog' => 'events#statementLog'
  match '/executedStatementsGraph' => 'events#executedStatementsGraph';
  match '/errorsOccuredGraph' => 'events#errorsOccuredGraph';
  match '/serverCPUandRAMgraph' => 'events#serverCPUandRAMgraph';

  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  root :to => "events#runningProcesses"
   #match '*not_found', to: 'error#404Error'
end
