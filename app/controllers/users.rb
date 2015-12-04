get '/users/logout' do
	session[:user_id] = nil
	redirect "/"
end

get "/users/:id" do
	@user = User.find(params[:id])
	erb :"user/show" 
end

get "/users/:id/my_questions" do
	@user = User.find(params[:id])
	erb :"user/my_questions"
end

get "/users/:id/my_answers" do
	@user = User.find(params[:id])
	erb :"user/my_answers"
end

post "/users/login" do
	@user = User.find_by(username: params[:username])
	if @user.nil?
		@error = "Username does not exist"
		redirect "/?error=#{@error}"
	elsif @user.authenticate(params[:password])
		session[:user_id] = @user.id
		redirect "/users/#{@user.id}"
	else
		@error = "Incorrect password"
		erb :"static/index"
	end
end

post "/users/new" do
	@user = User.new(full_name: params[:full_name], email: params[:email], username: params[:username], password: params[:password], password_confirmation: params[:password_confirmation])
	if @user.save	
		session[:user_id] = @user.id
		redirect "/users/#{@user.id}"
	else
		erb :"static/index"
	end
end

get '/users/:id/update/' do
	@user = User.find(params[:id])
	erb :'user/edit'
end

get '/users/:id/passwordchange/' do
	@user = User.find(params[:id])
	if params[:error]
		@error = params[:error]
	end
	erb :"user/change_password"
end

patch '/users/:id' do
	@user = User.find(params[:id])
	@user.update(full_name: params[:full_name], email: params[:email], username: params[:username], bio: params[:bio])
	
	redirect "/users/#{@user.id}"
end

patch '/users/:id/passwordchange' do
	@user = User.find(params[:id])
	
	if @user.authenticate(params[:password])
		@user.update(password: params[:newpassword], password_confirmation: params[:newpassword_confirmation])
		if @user.errors.any?
			erb :"user/change_password"
		end
	elsif @user.authenticate(params[:password]) == false
		@error = "Wrong current password"
		redirect "/users/#{session[:user_id]}/passwordchange/?error=#{@error}"
	else
		redirect "/users/#{@user.id}"
	end	
end

delete '/users/:id/delete' do
	user = User.find(params[:id])
	if user.questions.any?
		user.questions.destroy_all
	end
	if user.answers.any?
		user.answers.destroy_all
	end
	user.destroy
	session[:user_id] = nil
	redirect "/"
end

