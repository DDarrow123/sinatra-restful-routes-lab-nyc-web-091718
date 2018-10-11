class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

#loads new form
get '/recipes/new' do
erb :new
 end

get '/recipes' do
  @recipes = Recipe.all
  erb :index
  end

#shows a single recipe that belongs to a user - loads the 'show' page
get '/recipes/:id' do
  @recipe = Recipe.find_by_id(params[:id])
  erb :show
end

#edit - show form for user to edit a particular recipe
get '/recipes/:id/edit' do
  @recipe = Recipe.find_by_id(params[:id])
    erb :edit
end

#update - user can then update the form with new params, save it to the db, and then see it again at the id page
patch '/recipes/:id' do
  @recipe = Recipe.find_by_id(params[:id])
  @recipe.name = params[:name]
  @recipe.ingredients = params[:ingredients]
  @recipe.cook_time = params[:cook_time]
  @recipe.save

  redirect to "/recipes/#{@recipe.id}"

end

#creates a new instance of a recipe based on form params and redirects user to the page where they can see their newly created recipe
 post '/recipes' do
  @recipe = Recipe.create(params)
  redirect to "/recipes/#{@recipe.id}"
end

#deletes a recipe by id from the show page and then redirects user to index page to show deleted recipe from index

delete '/recipes/:id/delete' do
  @recipe = Recipe.find_by_id(params[:id])
  @recipe.delete
  redirect to '/recipes'
end


end
