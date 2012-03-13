class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    @movies = Movie.all
    if params[:commit]
      if params[:ratings]
        session[:chosen_ratings] = params[:ratings].keys
        @movies = Movie.where(:rating => session[:chosen_ratings])
      end
    elsif params[:sort]
      session[:sorting] = params[:sort]
      @date_hilite = session[:sorting] == "release_date" ? "hilite" : nil
      @title_hilite = session[:sorting] == "title" ? "hilite" : nil
      if params[:ratings]
        @movies = Movie.order(session[:sorting]).where(:rating => session[:chosen_ratings])
      else
        @movies = Movie.order(session[:sorting])
      end
    else
#      @movies = Movie.order(session[:sorting]).where(:ratings => session[:chosen_ratings])
      redirect_to movies_path(:sort => session[:sorting], :ratings => session[:chosen_ratings])
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
