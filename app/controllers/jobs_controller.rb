class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :creare, :update, :edit, :destroy]
  before_action :validate_search_key, only: [:search]

  def show
    @job = Job.find(params[:id])
    if @job.is_hidden
      # flash[:warning] = "你没有查看该职位的权限！"
      # redirect_to root_path
      redirect_to root_path, "你没有查看该职位的权限！"
    end
  end

  def index
    # 随机推荐五个职位 #
    @suggests = Job.published.random5

    @jobs = case params[:order]
        when 'by_lower_bound'
          Job.published.order('wage_lower_bound DESC').paginate(:page => params[:page], :per_page => 10)
        when 'by_upper_bound'
          Job.published.order('wage_upper_bound DESC').paginate(:page => params[:page], :per_page => 10)
        else
          Job.published.recent.paginate(:page => params[:page], :per_page => 10)
          # Job.published.order('created_at DESC')
        end
  end

  def search
    if @query_string.present?
      # 显示符合关键字的公开职位 #
      search_result = Job.ransack(@search_criteria).result(:distinct => true)
      @jobs = search_result.published.paginate(:page => params[:page], :per_page => 10 )
      # 随机推荐五个职位 #
      @suggests = Job.published.random5
    end
  end

  protected

  def validate_search_key
    # 去除特殊字符 #
    @query_string = params[:keyword].gsub(/\\|\'|\/|\?/, "") if params[:keyword].present?
    @search_criteria = search_criteria(@query_string)
  end

  def search_criteria(query_string)
    # 筛选多个栏位 #
    { :name_or_company_or_location_cont => query_string }
  end

  private

  def job_params
    params.require(:job).permit(:name, :title, :content, :category, :location, :description, :wage, :wage_unit, :contact, :is_hidden)
  end

end
