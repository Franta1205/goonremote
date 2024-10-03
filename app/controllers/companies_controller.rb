class CompaniesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @companies = Company.order(name: :asc)
  end

  def show
    @company = Company.find(params[:id])
    @jobs = @company.jobs
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.create(company_params)
    @company.user_id = current_user.id
    if @company.save
      redirect_to your_companies_companies_path, notice: "Company was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    if @company.update(company_params)
      redirect_to your_companies_companies_path, notice: "Company was successfully updated."
    else
      flash.now[:alert] = "There were some problems with your submission."
      render :edit
    end
  end

  def your_companies
    @companies = current_user.companies
    @jobs = Job.where(company: @companies).order(created_at: :desc)

    @pagy, @jobs = pagy(@jobs)
  end

  private

  def company_params
    params.require(:company).permit(:name, :website_url, :career_page, :linkedin, :x, :description, :logo)
  end
end
