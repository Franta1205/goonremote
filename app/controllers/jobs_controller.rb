class JobsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index remote_jobs show]
  before_action :set_job, only: %i[show edit update publish destroy]
  before_action :set_company, only: %i[new create]

  def index
    @jobs = Job.active.order(created_at: :desc)

    @pagy, @jobs = pagy(@jobs)
  end

  def show
    complain(message: "Listing is no longer active") unless @job.active? || @job.owner?(user: current_user)
  end

  def new
    redirect_to new_company_path unless current_user.companies.present?
    @job = Job.new
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

  def edit
    @job = Job.find(params[:id])
    @company = @job.company
    authorize! @job
  end

  def update
    @job = Job.find(params[:id])
    authorize! @job
    if @job.update(job_params)
      redirect_to your_companies_companies_path, notice: "Job was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    authorize! @job
    if @job.destroy
      redirect_to your_companies_companies_path, notice: "Job was succesfully deleted."
    else
      redirect_to your_companies_companies_path, alert: "There was an issue with deleting a job."
    end
  end

  def remote_jobs
    @jobs = Job.active.order(created_at: :desc)

    @pagy, @jobs = pagy(@jobs)
  end

  def publish
    authorize! @job
    unless @job.active?
      @job.update(published_at: Time.now)
      redirect_to checkout_index_path
    end
  end

  def your_job_listings
    @companies = current_user.companies
    @jobs = Job.where(company: @companies).order(created_at: :desc)

    @pagy, @jobs = pagy(@jobs)
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
