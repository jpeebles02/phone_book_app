class Api::ContactsController < ApplicationController
  before_action :authenticate_user
  def index
    if current_user 
      @contacts = current_user.contacts

      if params["search"]
        @contacts = @contacts.where("first_name ILIKE ? OR last_name ILIKE ?", "%#{params["search"]}%", "%#{params["search"]}%")
      end

      @contacts = @contacts.order(:id)
      render "index.json.jbuilder"
    else
      render json: {message: "You are not logged in."}
    end
  end

  def show
    if current_user 
      @contact = Contact.find_by(id: params[:id])
      render "show.json.jbuilder"
    else 
      render json: {message: "You are not logged in."}
    end
  end

  def create
    @contact = Contact.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      middle_name: params[:middle_name],
      phone_number: params[:phone_number],
      company: params[:company],
      email: params[:email],
      bio: params[:bio],
      user_id: current_user.id
      )
    if @contact.save
      render "show.json.jbuilder"
    else
      render json: {errors:@contact.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update 
    # if current_user
      @contact = Contact.find_by(id: params[:id])
      @contact.first_name = params[:first_name] || @contact.first_name
      @contact.last_name = params[:last_name] || @contact.last_name
      @contact.phone_number = params[:phone_number] || @contact.phone_number
      @contact.company = params[:company] || @contact.company
      @contact.middle_name = params[:middle_name] || @contact.middle_name
      @contact.bio = params[:bio] || @contact.bio
      @contact.email = params[:email] || @contact.email
      if @contact.save
        render "show.json.jbuilder"
      else
        render json: {errors:@contact.errors.full_messages}, status: :unprocessable_entity
      end
    # else 
    #   render json: {message: "You are not logged in."}
    # end
  end

  def destroy
    contact = Contact.find_by(id: params[:id])
    contact.destroy
    render json: {message: "Contact has been deleted!"}
  end
end
