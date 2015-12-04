get '/' do
	if session[:user_id] == nil
		@user = User.new
		if params[:error]
			@error = params[:error]
		end
	  	erb :"static/index"
	else
		redirect "/users/#{session[:user_id]}"
	end
end