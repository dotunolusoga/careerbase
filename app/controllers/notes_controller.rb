class NotesController < ApplicationController
  before_action :require_login, except: [:index, :show]

  def create
    @company = Company.find(params[:company_id])
    @note = Note.new(params.require(:note).permit(:content))
    @note.company = @company
    @note.user = current_user
    if @note.save
      redirect_to company_path(@company), notice: "Noted!"
    else
      flash.alert = "Your note could not be saved. Please correct the errors below."
      render "companies/show"
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @company = @note.company
    @note.destroy
    if @note.destroy
      redirect_to company_path(@company.id), notice: "Your note has been deleted."
    else
      flash.alert = "Note could not be deleted."
    end
  end


end
