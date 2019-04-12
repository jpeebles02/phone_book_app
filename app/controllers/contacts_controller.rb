class ContactsController < ApplicationController

  def index
    @contacts = Contact.all
    render "index.html.erb"
  end

  def new
    render "new.html.erb"
  end

  def create
    @contact = Contact.new(
      first_name: params[:first_name],
      middle_name: params[:middle_name],
      last_name: params[:last_name],
      phone_number: params[:first_name],
      email: params[:email],
      company: params[:company],
      bio: params[:bio]
    )
    @contact.save
    rediredt_to "/contacts/#{@contact.id}"
  end

  def show
    @contact = Contact.find_by(id: params[:id])
    render "show.html.erb"
  end

  def edit
    @contact = Contact.find_by(id: params[:id])
    render "edit.html.erb"
  end

  def update
    @contact = Contact.find_by(id: params[:id]),
    @contact.first_name = params[:first_name],
    @contact.middle_name = params[:middle_name],
    @contact.last_name = params[:last_name],
    @contact.first_name = params[:first_name],
    @contact.email = params[:email],
    @contact.company = params[:company]
    @contact.bio = params[:bio]
    rediredt_to "/contacts/#{@contact.id}"
  end

  def destroy
    @contact = Contact.find_by(id: params[:id]),
    @contact.destroy
    redirect_to "/contacts"
  end



end
