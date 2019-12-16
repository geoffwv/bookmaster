class BooksController < ApplicationController

  get '/books' do
    if logged_in?
      @user = current_user
      @books = @user.books 
      erb :'books/index'
    end
  end

  get '/books/new' do
    @users = User.all 
    erb :'/books/new'
  end

  post '/books' do
    user = User.find_by(id: params[:user_id])
    book = user.books.build(params)
    if book.save
      redirect "/books"
    else
      redirect "/books/new"
    end
  end

  get '/books/:id' do
    @book = Book.find_by(id: params[:id])
    if @book
      erb :'books/show'
    else
      redirect '/books'
    end
  end

  get "/books/:id/edit" do
    user = Book.find_by(id: params[:id]).user
    if user.id == current_user.id
      @users = User.all
      @book = user.books.find_by(id: params[:id])
      erb :'/books/edit'
    end
  end

  patch "/books/:id" do
    user = Book.find_by(id: params[:id])
    if user.id == current_user.id
      @book = user.books.find_by(id: params[:id])
      if @book.update(title: params[:title], author: params[:author], publisher: params[:publisher], genre: params[:genre])
        redirect "/books/#{@book.id}"
      else
        redirect "/books/#{@book.ed}/edit"
      end
    else
      redirect "/books"
    end
  end

  delete "/books/:id" do
    user = Book.find_by(id: params[:id])
    if user.id == current_user.id
      @book = Book.find_by(id: params[:id])
      @book.delete
      redirect"/books"
    end
  end

end