Mongoid::DocumentEditor::Engine.routes.draw do

  get "/:type/:id/edit", to: "documents#edit", as: :edit_document
  put "/:type/:id/edit", to: "documents#update", as: :update_document
  root                   to: "documents#index"

end
