class CompaniesController < ApplicationController
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
      @user = current_user
      if @user.companies.blank?
        redirect_to root_path, notice: "You have added no companies so far."
      else
        @companies = @user.companies
     end
  end

  def show
    @company = Company.find(params[:id])

    @address_string = ""
    @address_string << "- " + @company.street1 + ", " if @company.street1.present?
    @address_string << @company.street2 + " " if @company.street2.present?
    @address_string << @company.city + ", " if @company.city.present?
    @address_string << @company.state + " " if @company.state.present?
    @address_string << @company.zip if @company.zip.present?

    @email_string = ""
    @email_string << @company.email + " | " if @company.email.present?
    @email_string << @company.phone + " | " if @company.phone.present?
    @email_string << @company.url if @company.url.present?

    @notes = @company.notes.all
    @note = Note.new
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
      message = "#{@company.name} has been updated."
    else
      message = "#{@company.name} is unchanged."
    end
    redirect_to @company, notice: message
  end


  protected

  def load_company
    if params[:id].present?
      @company = company.find(params[:id])
    else
      @company = company.new
    end

    if params[:company].present?
      @company.assign_attributes(company_params)
    end
  end

  def load_user
    @user = User.find(params[:user_id])
  end

  def company_params
    params.require(:company).permit(:name, :url, :user_id, :street1, :street2, :city, :state, :zip, :description, :phone, :url, :email, :contact_name, :emp_count, :industry)
  end

end
