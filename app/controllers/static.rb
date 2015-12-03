get '/' do
	@user = User.new
	if params[:error]
		@error = params[:error]
	end
  	erb :"static/index"
end