class JobsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index remote_jobs show]
  before_action :set_job, only: %i[show edit update]
  before_action :set_company, only: %i[new edit create]

  def index
    @jobs = Job.all
  end

  def show
  end

  def new
    redirect_to new_company_path unless current_user.companies.present?
    @job = Job.new
  end

  def edit
    @job = Job.find(params[:id])
  end

  def create
    @job = Job.new(job_params)
    @job.company = @company
    if @job.save
      redirect_to @job, notice: "Job was succesfully created."
    else
      render :new
    end
  end

  def update
  end

  def remote_jobs
    @jobs = Job.order(created_at: :desc)
  end

  private

  def job_params
    params.require(:job).permit(:title, :apply_link, :description, :salary_min, :salary_max, :currency, :salary_period)
  end

  def set_job
    @job = Job.find(params[:id])
  end

  def set_company
    @company = Company.find(params[:company_id])
  end
end
