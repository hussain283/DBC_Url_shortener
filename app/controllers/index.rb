get '/' do
  @urls = Url.all
  erb :index
end

get '/new' do
  @url = Url.new
  erb :url_form
end

post '/urls' do
  @url = Url.new(params[:url])
  if @url.valid?
    @url = Url.create!(params[:url])
    redirect "/"
  else
    erb :url_form
  end
end

get '/:short_url' do
  begin
    @url = Url.find_by_short_address(params[:short_url])
    @url.increment!(:click_count)
    redirect @url.address
  rescue
    redirect "http://www.youtube.com"
  end 
end