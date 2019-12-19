class BooksController < ApplicationController

  get '/books' do
    if logged_in?
      @user = current_user
      @books = @user.books 
      erb :'books/index'
    else
      redirect "/"
    end
  end

  get '/books/new' do
    if logged_in?
      erb :'/books/new'
    else
      redirect "/"
    end
  end

  post '/books' do
    if logged_in?
      user = current_user
      book = user.books.build(params)
      if book.save
        redirect "/books/#{book.id}"
      else
        redirect "/books/new"
      end
    else
      redirect "/"
    end
  end

  get '/books/:id' do
    if logged_in?
      @book = current_user.books.find_by(id: params[:id])
      if @book
        erb :'books/show'
      else
        redirect '/books'
      end
    end
  end

  get "/books/:id/edit" do
    if logged_in?
      @book = current_user.books.find_by(id: params[:id])
      if @book 
        erb :'/books/edit'
      else
       redirect '/books'
      end
    else
      redirect '/'
    end
  end

  patch "/books/:id" do
    if logged_in?
      book = current_user.books.find_by(id: params[:id])
      if book.update(title: params[:title], author: params[:author], publisher: params[:publisher], genre: params[:genre])
        redirect "/books/#{book.id}"
      else
        redirect "/books/#{book.ed}/edit"
      end
    else
      redirect "/"
    end
  end

  delete "/books/:id" do
    if logged_in?
      book = current_user.books.find_by(id: params[:id])
      if book
        book.delete
      end
      redirect "/books"
    else
      redirect "/"
    end
  end

end