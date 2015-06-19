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

    any_change = false
    changed_keys = []

    params["company"].keys.each do |key|
      params_value = params["company"][key].to_s
      current_company_value = @company.attributes[key].to_s
      if params_value != current_company_value
        any_change = true
        changed_keys << key
      end
    end

    if any_change
      @company.update_attributes(company_params)
      message = "#{@company.name} has been updated. We changed these keys: #{changed_keys.join(',')}"
    else
      message = "#{@company.name} is unchanged."
    end
    redirect_to @company, notice: message
  end


  protected

  def company_params
    params.require(:company).permit(:name, :url, :street1, :street2, :city, :state, :zip, :description, :phone, :url, :email, :contact_name, :emp_count, :industry)
  end

end
