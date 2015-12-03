get '/users/logout' do
	session[:user_id] = nil
	redirect "/"
end

get "/users/:id" do
	@user = User.find(params[:id])
	erb :"user/show" 
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

get '/users/:id/update' do
	@user = User.find(params[:id])
	erb :'user/edit'
end

patch '/users/:id' do
	user = User.find(params[:id])
	user.update(full_name: params[:full_name], email: params[:email], username: params[:username], password: params[:password], bio: params[:bio])
	redirect "/users/#{user.id}"
end

delete '/users/:id' do
	user = User.find(params[:id])
	user.destroy
	redirect "/"
end

