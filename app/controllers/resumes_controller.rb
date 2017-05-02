class ResumesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :favorite]
  before_action :validate_search_key, only: [:search]

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

  def search
    if @query_string.present?
      search_result = Resume.ransack(@search_criteria).result(:distinct => true)
      @resumes = search_result.paginate(:page => params[:page], :per_page => 5 )
    end
  end

  protected

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
    @search_criteria = search_criteria(@query_string)
  end

  def search_criteria(query_string)
    { :title_cont => query_string }
  end

  private

  def resume_params
    params.require(:resume).permit(:name, :title, :content, :description, :category, :location, :wage, :wage_unit, :contact, :is_hidden)
  end

end
