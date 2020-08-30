class ProjectsController < ApplicationController
  before_action :authenticate_user!
  #after_filter :set_request_from
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.where(closed: false)
                       .order(start_date: :desc, end_date: :asc, created_at: :desc)
    @project = Project.new
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    @project_statuses = ProjectStatus.where(project_id: params[:id])
                                     .order(updated_at: :desc)
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    project = Project.new

    # 変数設定
    name = params[:project][:name]
    summary = params[:project][:summary]
    start_date = params[:project][:start_date]
    end_date = params[:project][:end_date]

    # 入力チェック
    if name.blank?
      flash[:error] = "プロジェクト名を入力してください"
      redirect_to projects_path
      return
    end
    if summary.blank?
      flash[:error] = "概要を入力してください"
      redirect_to projects_path
      return
    end
    if start_date.blank?
      flash[:error] = "開始日を入力してください"
      redirect_to projects_path
      return
    end

    # プロジェクト作成
    project.name = name
    project.summary = summary
    project.start_date = start_date
    project.end_date = end_date if end_date.present?
    
    # 作成処理実行
    if project.save
      flash[:notice] = "新規プロジェクトを作成しました"
      redirect_to projects_path
      return
    else
      flash[:error] = "新規プロジェクトの作成に失敗しました"
      redirect_to projects_path
      return
    end

    # @project = Project.new(project_params)

    # respond_to do |format|
    #   if @project.save
    #     format.html { redirect_to @project, notice: 'Project was successfully created.' }
    #     format.json { render :show, status: :created, location: @project }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @project.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # プロジェクト作成
  def create_project_status

  end

  # 投稿作成
  def create_project_status
    # 変数設定
    project = Project.find(params[:id])
    project_status = ProjectStatus.new

    # 入力チェック
    if params[:status].blank?
      flash[:error] = "投稿内容を入力してください"
      redirect_to project_path(project), id: params[:id]
      return
    end

    # 値を格納
    project_status.project_id = params[:id]
    project_status.user_id = current_user.id
    project_status.status = params[:status]

    # 削除実行・元のページへリダイレクト
    if project_status.save!
      flash[:notice] = "投稿しました"
    else
      flash[:error] = "投稿に失敗しました"
    end
    redirect_to project_path(project), id: params[:id]
  end

  # 投稿削除
  def destroy_project_status
    # 変数設定
    project = Project.find(params[:id])
    project_status = ProjectStatus.find(params[:project_status_id])
    project_status_updated_at = project_status.updated_at.strftime("%Y/%m/%d %H:%M")

    # 削除実行
    project_status.destroy!

    # 元のページへリダイレクト
    flash[:notice] = "#{project_status_updated_at} の投稿を削除しました"
    redirect_to project_path(project), id: params[:id]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.fetch(:project, {})
    end
end
