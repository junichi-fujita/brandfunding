class ProjectsController < ApplicationController
  before_action :require_login, only: %i[show new create]
  before_action :set_project, only: %i[show edit update destroy]

  def index
    @projects = Project.all.reverse_order
  end

  def new
    if current_user.ideas.count == 0
      redirect_to new_idea_path, alert: "アイディアの登録をお願いします。"
    else
      @project = Project.new
      @project.build_project_about
      @project.build_project_idea
      @project.build_project_image
      @project.build_project_report
      @project.project_return.build
      @project.build_project_sponsor
      @project.build_project_value
      @ideas = current_user.ideas
    end
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      redirect_to project_path(@project), notice: "プロジェクトを登録しました。"
    else
      flash.now[:alert] = "プロジェクトの登録に失敗しました。"
      render :new
    end
  end

  def show
    @comments = @project.comments
    @comment = Comment.new
    @project_return = ProjectReturn.new
    if logged_in?
      @like = current_user.project_likes.find_by(project_id: @project.id)
    else
      @like = nil
    end
  end

  def edit
    @ideas = current_user.ideas
    unless @project.user_id == session[:user_id]
      redirect_to projects_path, notice: "他のユーザーのプロジェクトは編集できません。"
    end
  end

  def update
    if @project.update(project_params)
      redirect_to projects_path, notice: "プロジェクトを更新しました。"
    else
      flash.now[:alert] = "プロジェクトの更新に失敗しました。"
      render :edit
    end
  end

  def confirm
    @project = current_user.projects.build(project_params)
    render :new if @project.invalid?
  end

  def destroy
    if @project.user_id == session[:user_id]
      @project.destroy
        redirect_to projects_path, notice:"プロジェクトを削除しました。 "
      else
        redirect_to projects_path, notice: "他のユーザーのプロジェクトは削除できません。"
    end
  end

  private

  def project_params
    params.require(:project).permit!
    # params.require(:project).permit(
    #   :project_title,
    #   :project_text,
    #   project_about_attributes: [
    #     :id,
    #     :project_abouts
    #   ],
    #   project_idea_attributes: [
    #     :id,
    #     :project_returns
    #   ],
    #   project_image_attributes: [
    #     :id,
    #     :project_logo,
    #     :project_img,
    #     :project_img2,
    #     :project_img3,
    #     :project_img4,
    #     :project_img5,
    #     :project_movie
    # ],
    # project_report_attributes: [
    #   :id,
    #   :project_reports
    # ],
    # project_return_attributes: [
    #   :id,
    #   :return_title,
    #   :return_item_img,
    #   :return_item_fund,
    #   :return_item_count,
    #   :return_item_sponsors,
    #   :delivery_date,
    #   :return_item_remark,
    #   :return_option
    # ],
    # project_sponsor_attributes: [
    #   :id,
    #   :sponsors_list
    # ],
    # project_value_attributes: [
    #   :id,
    #   :target_fund,
    #   :project_fund,
    #   :recruitment_method,
    #   :recruitment_deadline
    # ]
    # )
  end

  def set_project
    @project = Project.find(params[:id])
  end


end
