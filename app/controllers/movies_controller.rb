class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  # GET /movies
  # GET /movies.json
  def index
    @q = Movie.ransack(params[:q])
    @movies = @q.result(distinct: true)
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    @movie = Movie.find(params[:id])
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
    @movie = Movie.find(params[:id])
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #http://localhost:3000/movies/get_genres?name=A
  def get_genres
    @gterm = params[:name]
    @allgenre = Genre.all
    @final_genre = []
    @get_genre = nil

    @allgenre.each do |gr|
      if gr.name.include? @gterm.titleize
        @get_genre = Genre.where(name: gr.name)
        @final_genre += @get_genre
      else
        next
      end
    end
    render json: @final_genre    
  end

  #http://localhost:3000/movies/get_authors?first_name=C
  def get_authors
    @wterm = params[:first_name]
    @allwriters = Writer.all
    @final_writers = []
    @get_writer = nil

    @allwriters.each do |wr|
      if wr.first_name.include? @wterm.titleize
        @get_writer = Writer.where(first_name: wr.first_name)
        @final_writers += @get_writer
      else
        next
      end
    end
    render json: @final_writers      
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :short_desc, {genre_list: []}, {writer_list: []})
    end
end
