class ArticleSeriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article_series, only: [:show, :edit, :update, :destroy]

  # GET /article_series
  # GET /article_series.json
  def index
    @article_series = ArticleSeries.where(publish_status: :published)
                                   .order(created_at: :desc)
  end

  # GET /article_series/1
  # GET /article_series/1.json
  def show
  end

  # GET /article_series/new
  def new
    @article_series = ArticleSeries.new
  end

  # GET /article_series/1/edit
  def edit
  end

  # POST /article_series
  # POST /article_series.json
  def create
    @article_series = ArticleSeries.new(article_series_params)

    respond_to do |format|
      if @article_series.save
        format.html { redirect_to @article_series, notice: 'Article series was successfully created.' }
        format.json { render :show, status: :created, location: @article_series }
      else
        format.html { render :new }
        format.json { render json: @article_series.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /article_series/1
  # PATCH/PUT /article_series/1.json
  def update
    respond_to do |format|
      if @article_series.update(article_series_params)
        format.html { redirect_to @article_series, notice: 'Article series was successfully updated.' }
        format.json { render :show, status: :ok, location: @article_series }
      else
        format.html { render :edit }
        format.json { render json: @article_series.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /article_series/1
  # DELETE /article_series/1.json
  def destroy
    @article_series.destroy
    respond_to do |format|
      format.html { redirect_to article_series_index_url, notice: 'Article series was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article_series
      @article_series = ArticleSeries.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_series_params
      params.fetch(:article_series, {})
    end
end
