class Admin::ResumesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin
  layout "admin"
  # def index
  #   @job = Job.find(params[:job_id])
  #   @resumes = @job.resumes.order('created_at DESC')
  # end

  def show
    @resume = Resume.find(params[:id])
  end

  def index
    # @resumes = Resume.all.order("created_at DESC")
    # @resumes = Resume.all
    @resumes = case params[:order]
    when 'by_lower_bound'
      Resume.order('wage_lower_bound DESC').paginate(:page => params[:page], :per_page => 10)
    when 'by_upper_bound'
      Resume.order('wage_upper_bound DESC').paginate(:page => params[:page], :per_page => 10)
    else
      Resume.recent.paginate(:page => params[:page], :per_page => 10)
      # Resume.published.order('created_at DESC')
    end
  end

  def new
    @resume = Resume.new
  end

  def create
    @resume = Resume.new(resume_params)

    if @resume.save
      redirect_to admin_resumes_path, notice: "添加简历成功"
    else
      render :new
    end
  end

  def edit
    @resume = Resume.find(params[:id])
  end

  def update
    @resume = Resume.find(params[:id])
    if @resume.update(resume_params)
      redirect_to admin_resumes_path, notice: "编辑简历成功！"
    else
      render :edit
    end
  end

  def destroy
    @resume = Resume.find(params[:id])
    @resume.destroy
    redirect_to admin_resumes_path, alert: "删除简历成功！"
  end

  def publish
    @resume = Resume.find(params[:id])
    @resume.publish!
    # @resume.is_hidden = false
    # @resume.save
    redirect_to :back
  end

  def hide
    @resume = Job.find(params[:id])
    @resume.hide!
    # @resume.is_hidden = true
    # @resume.save
    redirect_to :back
  end

  private

  def resume_params
    params.require(:resume).permit(:name, :title, :content, :description, :category, :location, :wage, :wage_unit, :contact, :is_hidden)
  end

end
