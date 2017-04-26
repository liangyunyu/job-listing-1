class Admin::JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]
  before_action :require_is_admin
  layout "admin"

  def show
    @job = Job.find(params[:id])
  end

  def index
    # @jobs = Job.all.order("created_at DESC")
    # @jobs = Job.all
    @jobs = case params[:order]
        when 'by_lower_bound'
          Job.published.order('wage_lower_bound DESC')
        when 'by_upper_bound'
          Job.published.order('wage_upper_bound DESC')
        else
          Job.published.recent
          # Job.published.order('created_at DESC')
        end
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)

    if @job.save
      redirect_to admin_jobs_path
    else
      render :new
    end
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
      redirect_to admin_jobs_path
    else
      render :edit
    end
  end

  def destroy
    @job = Job.find(params[:id])

    @job.destroy

    redirect_to admin_jobs_path
  end

  def publish
    @job = Job.find(params[:id])
    @job.publish!
    # @job.is_hidden = false
    # @job.save
    redirect_to :back
  end

  def hide
    @job = Job.find(params[:id])
    @job.hide!
    # @job.is_hidden = true
    # @job.save
    redirect_to :back
  end

  private

  def job_params
    params.require(:job).permit(:name, :title, :content, :category, :location, :description, :wage, :wage_unit, :contact, :is_hidden)
  end

end
