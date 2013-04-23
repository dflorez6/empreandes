class StaticsController < ApplicationController
  # GET /statics
  # GET /statics.json
  def index

  end

  def new
    password = params[:password]
    username = params[:username]
    act_code= SecureRandom.urlsafe_base64
    @user = User.new(:password=>password,:admin=>false, :email=>username, :act_code=>act_code, :activated=>false,
                     :fb_connected=>false)

    if @user.save
      sign_in(@user)
      UserMailer.welcome_email(@user).deliver
      flash[:notice] = "Listo! Revisa tu correo para el codigo de confirmacion!"
      redirect_to current_user
    else
      if @user.errors[:email]
        flash[:error]= @user.errors[:email].to_sentence
      elsif @user.errors[:password]
        flash[:error]= @user.errors[:password].to_sentence
      end
      render "register"
    end
  end

  def register

  end

  def create
    auth = request.env["omniauth.auth"]

     current_user.uid = auth.uid
     current_user.name = auth.info.name
     current_user.oauth_token = auth.credentials.token
     current_user.oath_expires_at = Time.at(auth.credentials.expires_at)
     current_user.fb_connected=true
     current_user.fb_image_link=auth.info.image.split("=")[0] << "=large"
     current_user.save!
    sign_in(current_user)
    redirect_to "/"
  end
  
  def ingresar
    mail = params[:mail]
    pswd = params[:pswd]
    user = User.where(:email => mail, :password => pswd).first
    userToSendMail = User.where(:email=>mail).first
    if params[:commit]=="Olvide mi password!"
      if !userToSendMail
        flash[:error] = "No existe un usuario con esas credenciales para enviar el correo de recordatorio de password."
      else
        #Reenviar pswd
        UserMailer.reenviar_pswd(userToSendMail).deliver
        flash[:notice] = "Te acabamos de reenviar tu password. Revisa tu correo!"
      end
    elsif( mail.blank? || pswd.blank?)
        flash[:error] = "Por favor llena todos los campos."
    else
      #Ingreso completamente los campos

      if(!user)
        flash[:error] = "No se encontro ningun usuario con esas credenciales."
      else
        sign_in(user)
      end
    end
    redirect_to "/"
  end

  def salir
    current_user =nil
    cookies.delete :remember_token
    redirect_to "/"
  end

  def activation

    if params[:commit] == "Reenviar correo de activacion"
      if(!params[:mail])
        flash[:error]="Si deseas que se te reenvie el correo de activacion, debes ingresar tu correo uniandes (con o sin @)"
      else
        @user = User.find_by_email(params[:mail])
        if(@user)
          UserMailer.welcome_email(@user).deliver
          flash[:notice]="Revisa tu correo de nuevo!"
        else
          flash[:error]="Dicho usuario no existe en el sistema. Intenta ingresar tus datos de nuevo!"
        end
      end
    elsif params[:commit]=="Activar cuenta"
      @user = User.find_by_email(params[:mail])
      if @user
        code = params[:codigo]
        if @user.act_code==code
          if @user.activated
            flash[:notice] = "Tu cuenta ya fue activida! No tienes necesidad de hacerlo de nuevo"
          else
            @user.activated=true
            @user.save!
            sign_in(@user)
            redirect_to "/"
          end
        else
          flash[:error]="El codigo que ingresaste no corresponde a ese usuario."
        end
      else
        flash[:error]="Dicho usuario no existe en el sistema. Intenta ingresar tus datos de nuevo!"
      end

    end
  end


  def equipo

  end

  def contacto
    email = params[:correo]
    name = params[:nombre]
    body = params[:body]

    if(params[:commit]=="Enviar correo")
      if(name.blank? || email.blank?)
        flash[:error]="Llena todos los datos porfavor."
      else
        begin
          UserMailer.contact_email(name,email,body).deliver
          flash[:notice]="Correo enviado! Apenas podamos nos comunicamos contigo."
        rescue
          flash[:error]="Also salio mal. Verifica la direccion de correo que introduciste."
        end
      end
    end

  end

  def proyectos

  end

  def reclutamiento
    name = params[:nombre]
    career = params[:carrera]
    semester = params[:semestre]
    area = params[:area]
    coments = params[:body]

    if(params[:commit]=="Enviar")
      if(name.blank? || career.blank? || area.blank? || coments.blank?)
        flash[:error]="Llena todos los datos porfavor."
      else
        begin
          UserMailer.reclut_email(name,career,semester,area,coments).deliver
          flash[:notice]="Correo enviado! Apenas podamos nos comunicamos contigo."
        rescue
          flash[:error]="Also salio mal. Disculpa las molestias! Intentalo de nuevo."
        end
      end
    end

  end

end
