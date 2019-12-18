class BooksController < ApplicationController

  get '/books' do
    if logged_in?
      @user = current_user
      @books = @user.books 
      erb :'books/index'
      
    end
  end

  get '/books/new' do
    erb :'/books/new'
  end

  post '/books' do
    if logged_in?
      user = current_user
      book = user.books.build(params)
      if book.save
        redirect "/books"
      else
        redirect "/books/new"
      end
    else
      redirect "/"
    end
  end

  get '/books/:id' do
    # @book = Book.find_by(id: params[:id])
    if logged_in?
      user = current_user
      # book = user.books  
      # book = user.books.build(params)
      if @book
        erb :'books/show'
      else
        redirect '/books'
      end
    end
  end

  get "/books/:id/edit" do
    if logged_in?
      user = current_user
      # book = user.books
      # user = Book.find_by(id: params[:id]).user
      if user == current_user
        @users = User.all
        @book = user.book
        erb :'/books/edit'
      end
    end
  end

  patch "/books/:id" do
    if logged_in?
      user = current_user
      book = user.books
    # user = Book.find_by(id: params[:id])
      if user == current_user
        @book = current_user
        if @book.update(title: params[:title], author: params[:author], publisher: params[:publisher], genre: params[:genre])
          redirect "/books/#{@book.id}"
        else
          redirect "/books/#{@book.ed}/edit"
        end
      else
        redirect "/books"
      end
    end
  end

  delete "/books/:id" do
    # user = Book.find_by(id: params[:id])
    if logged_in?
      user = current_user
      book = user.books
      if user == current_user
        @book = current_user
        @book.delete
        redirect"/books"
      end
    end
  end

end