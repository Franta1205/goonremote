class JobsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index remote_jobs show]
  before_action :set_job, only: %i[show edit update confirm_publish publish]
  before_action :set_company, only: %i[new edit create]

  def index
    @jobs = Job.active.order(created_at: :desc)

    @pagy, @jobs = pagy(@jobs)
  end

  def show
  end

  def new
    redirect_to new_company_path unless current_user.companies.present?
    @job = Job.new
  end

  def edit
    @job = Job.find(params[:id])
    authorize! @job
  end

  def create
    @job = Job.new(job_params)
    @job.company = @company
    authorize! @job
    if @job.save
      redirect_to @job, notice: "Job was succesfully created."
    else
      render :new
    end
  end

  def update
    @job = Job.find(params[:id])
    authorize! @job
  end

  def remote_jobs
    @jobs = Job.active.order(created_at: :desc)

    @pagy, @jobs = pagy(@jobs)
  end

  def pending_jobs
    authorize!
    @jobs = Job.all.where(published_at: nil)
  end

  def confirm_publish
    authorize!
  end

  def publish
    authorize!
    @job.update(published_at: Time.now)
  end

  private

  def job_params
    params.require(:job).permit(:title, :apply_link, :description, :salary_min, :salary_max, :currency, :salary_period, :location)
  end

  def set_job
    @job = Job.find(params[:id])
  end

  def set_company
    @company = Company.find(params[:company_id])
  end
end
