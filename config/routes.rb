Mongoid::DocumentEditor::Engine.routes.draw do

  get "/:type/:id/edit", to: "documents#edit", as: :edit_document
  put "/:type/:id/edit", to: "documents#update", as: :update_document
  get "/:type",          to: "documents#index", as: :documents

end