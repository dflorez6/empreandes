class UsersController < ApplicationController

  # GET /users
  # GET /users.json
  def index
    @users = User.search(params[:search])
    @search = params[:search]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @isMe = signed_in? && current_user.email== @user.email

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    if(params[:conf]!=params[:user][:password])
        flash[:error] = "Las contrasenas no coinciden."
        render "edit"
    else
        respond_to do |format|
          if @user.update_attributes(params[:user])
            sign_in(@user)
            format.html { redirect_to @user, notice: 'Tu informacion ha sido actualizada.' }
            format.json { head :no_content }
          else
            format.html { render action: "edit", notice: 'whut' }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        end
     end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def myteam
  @user  = current_user
  @isMe = signed_in? && current_user.email== @user.email
  @can = @user.estado!="Quiero emprender!"
  if !@user.blank?
        @equipo = Equipo.find_by_user_id(@user.id)
        @extra1 = User.find_by_email(@equipo.mail_user1)
        @extra2 = User.find_by_email(@equipo.mail_user2)
        @extra3 = User.find_by_email(@equipo.mail_user3)
  end
    if params[:commit]=="Crear equipo"
       @user.has_team = true
       @equipo = @user.create_equipo(:name=>"", :max=>4, :user_id=>@user.id, :user1=>"N/A", :mail_user1=>"N/A",:user2=>"N/A", :mail_user2=>"N/A",:user3=>"N/A", :mail_user3=>"N/A")
       @equipo.save!
       @user.save!
       sign_in(@user)

    elsif params[:commit] == "Editar mi equipo"
        @equipo.name = params[:nombre]
        @equipo.user1 = params[:u1]
        @equipo.mail_user1 = params[:cu1]
        @equipo.user2 = params[:u2]
        @equipo.mail_user2 = params[:cu2]
        @equipo.user3 = params[:u3]
        @equipo.mail_user3 = params[:cu3]
        @equipo.nit = params[:nit]
        @equipo.save


    end

  end
end
