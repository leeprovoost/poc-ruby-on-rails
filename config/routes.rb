MusicApp::Application.routes.draw do

  resources :tracks
  resources :djs

  root to: "tracks#index"
end
