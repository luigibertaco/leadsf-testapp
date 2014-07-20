class LeadsController < ApplicationController
  before_action :set_leadsf
  before_action :set_lead, only: [:show, :edit, :destroy, :login]

  def index
    @leads = @leadsf.list
  end


  def show
  end

  def new
    @lead = @leadsf.new
  end

  def edit
  end

  def save
    lead = @leadsf.new
    lead.Id = lead_params[:Id]
    lead.FirstName = lead_params[:FirstName]
    lead.LastName = lead_params[:LastName]
    lead.Email = lead_params[:Email]
    lead.Company = lead_params[:Company]
    lead.Title = lead_params[:Title]
    lead.Phone = lead_params[:Phone]
    lead.Website = lead_params[:Website]
    if @leadsf.save(lead)
      redirect_to leads_url, notice: 'Lead was successfully saved.'
    else
      render leads_url, notice: 'Error'
    end
  end

  def destroy
    @leadsf.destroy(@lead.Id)
    redirect_to leads_url, notice: 'Lead was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leadsf
      @account = Account.find(session[:account_logged])
      @leadsf = Leadsf.set(@account.username, @account.password, @account.security_token, ENV['SALESFORCE_KEY'], ENV['SALESFORCE_SECRET'])
    end

    def set_lead
      @lead = @leadsf.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lead_params
      params.require(:lead).permit(:Id, :FirstName, :LastName, :Email, :Company, :Title, :Phone, :Website)
    end
end
