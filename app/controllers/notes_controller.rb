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

end
