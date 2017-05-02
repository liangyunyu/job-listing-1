class ResumesController < ApplicationController
  before_action :authenticate_user!

  def index
    # @resumes = Resume.all
    @resumes = case params[:order]
    when 'by_lower_bound'
      # Resume.published.lower_wage.paginate(:page => params[:page], :per_page => 5)
      Resume.lower_wage.paginate(:page => params[:page], :per_page => 5)
    when 'by_upper_bound'
      # Resume.published.upper_wage.paginate(:page => params[:page], :per_page => 5)
      Resume.upper_wage.paginate(:page => params[:page], :per_page => 5)
    else
      # Resume.published.recent.paginate(:page => params[:page], :per_page => 5)
      Resume.recent.paginate(:page => params[:page], :per_page => 5)
    end
  end

  def new
    @job = Job.find(params[:job_id])
    @resume = Resume.new
  end

  def create
    @job = Job.find(params[:job_id])
    @resume = Resume.new(resume_params)
    @resume.job = @job
    @resume.user = current_user

    if @resume.save
      flash[:notice] = "成功提交履历"
      redirect_to job_path(@job), notice: "你已成功投递简历！"
    else
      render :new
    end

  end

  private

  def resume_params
    params.require(:resume).permit(:content, :attachment)
  end

end
