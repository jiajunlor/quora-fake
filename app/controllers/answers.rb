get "/questions/new" do
	@user = User.find(session[:user_id])
	erb :"question/form"
end

post "/questions" do
	@question = Question.create(user_id: session[:user_id], text:params[:text])
	redirect "/users/#{session[:user_id]}"
end

get "/questions" do
	erb :"question/all"
end

get "/questions/:id/single" do
	@question = Question.find(params[:id])
	erb :"question/single"
end

get '/questions/:id/update' do
	@question = Question.find(params[:id])
	erb :'question/edit'
end

patch '/questions/:id' do
	question = Question.find(params[:id])
	question.update(text: params[:text])
	redirect "/questions/#{params[:id]}/single"
end

delete '/questions/:id' do
	question = Question.find(params[:id])
	question.destroy
	redirect "/users/#{session[:user_id]}"
end