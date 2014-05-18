Mongoid::Scribe::Engine.routes.draw do

  scope("/:type/") do
    get    "new",      to: "documents#new",     as: :new_document
    post   "new",      to: "documents#create",  as: :create_document
    get    ":id/edit", to: "documents#edit",    as: :edit_document
    get    ":id",      to: "documents#show",    as: :document
    put    ":id/edit", to: "documents#update",  as: :update_document
    get    "",         to: "documents#index",   as: :documents
    delete ":id",      to: "documents#destroy", as: :destroy_document
  end

  root to: "documents#all"

end
