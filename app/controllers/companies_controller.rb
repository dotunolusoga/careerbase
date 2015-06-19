require 'pry'

class CompaniesController < ApplicationController


  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to root_path, notice: "#{@company.name} has now been added."
    else
       flash.alert = "Please fix the errors below to continue."
       render :new
    end
  end

  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(company_params)
      message = "#{@company.name} has been updated. #{@company.changed}"
    else
      message = "#{@company.name} is unchanaged."
    end
    redirect_to @company, notice: message
  end


  protected

  def company_params
    params.require(:company).permit(:name, :url, :street1, :street2, :city, :state, :zip, :description, :phone, :url, :email, :contact_name, :emp_count, :industry)
  end

end
