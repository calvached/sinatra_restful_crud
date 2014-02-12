get '/' do

  erb :index
end

post '/send_note' do
  Note.create(title: params[:title], content: params[:content])

  redirect '/view_all_notes'
end

get '/view_all_notes' do
  @notes = Note.all

  erb :view_all_notes
end

get '/notes/:id' do
  note = Note.find(params[:id])
  session[:note_id] = params[:id]
  @title = note[:title]
  @content = note[:content]

  erb :edit_note
end

post '/edit_note' do
  note = Note.find(session[:note_id])
  note.update(title: params[:title],
              content: params[:content])

  redirect '/view_all_notes'
end

post '/delete_note' do
  Note.find(session[:note_id]).destroy
  redirect '/view_all_notes'
end
