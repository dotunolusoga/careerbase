class CompaniesController < ApplicationController
  # before_filter :load_user
  before_filter :require_login


  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    @company.user_id = current_user.id
    if @company.save
      redirect_to companies_path, notice: "#{@company.name} has now been added."
    else
       flash.alert = "Company could not be saved. Please fix the errors to continue."
       render :new
    end
  end

  def index
    #if @user == current_user
      @companies = Company.all
    # else
      # redirect_to root_path, notice: "You have added no companies so far."
    # end
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

  def load_user
    @user = User.find(params[:user_id])
  end

  def company_params
    params.require(:company).permit(:name, :url, :user_id, :street1, :street2, :city, :state, :zip, :description, :phone, :url, :email, :contact_name, :emp_count, :industry)
  end

end
