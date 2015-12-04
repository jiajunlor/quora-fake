post "/answers" do
	@answer = Answer.create(user_id: session[:user_id], question_id: params[:question_id], content:params[:content])
	redirect "/questions/#{params[:question_id]}/single"
end

get '/answers/:id/update' do
	@answer = Answer.find(params[:id])
	erb :'answer/edit'
end

patch '/answers/:id' do
	answer = Answer.find(params[:id])
	answer.update(content: params[:content])
	redirect "/questions/#{params[:id]}/single"
end

delete '/answers/:id' do
	answer = Answer.find(params[:id])
	answer.destroy
	redirect "/questions/#{params[:question_id]}/single"
end