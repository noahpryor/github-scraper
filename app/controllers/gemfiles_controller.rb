class GemfilesController < ApplicationController
  before_action :set_gemfile, only: [:show, :edit, :update, :destroy]

  # GET /gemfiles
  # GET /gemfiles.json
  def index
    @gemfiles = Gemfile.all
  end

  # GET /gemfiles/1
  # GET /gemfiles/1.json
  def show
  end

  # GET /gemfiles/new
  def new
    @gemfile = Gemfile.new
  end

  # GET /gemfiles/1/edit
  def edit
  end

  # POST /gemfiles
  # POST /gemfiles.json
  def create
    @gemfile = Gemfile.new(gemfile_params)

    respond_to do |format|
      if @gemfile.save
        format.html { redirect_to @gemfile, notice: 'Gemfile was successfully created.' }
        format.json { render action: 'show', status: :created, location: @gemfile }
      else
        format.html { render action: 'new' }
        format.json { render json: @gemfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gemfiles/1
  # PATCH/PUT /gemfiles/1.json
  def update
    respond_to do |format|
      if @gemfile.update(gemfile_params)
        format.html { redirect_to @gemfile, notice: 'Gemfile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @gemfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gemfiles/1
  # DELETE /gemfiles/1.json
  def destroy
    @gemfile.destroy
    respond_to do |format|
      format.html { redirect_to gemfiles_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gemfile
      @gemfile = Gemfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gemfile_params
      params.require(:gemfile).permit(:repository_id, :url, :contents, :last_checked)
    end
end
