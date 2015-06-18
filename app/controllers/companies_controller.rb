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

  protected

  def company_params
    params.require(:company).permit(:name, :url)
  end

end
