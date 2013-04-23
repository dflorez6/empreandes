class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  default

  def welcome_email(user)
    mail(:to => user.email, :subject => "Bienvenido a ANEEU!", :body => "Solo te falta activar tu cuenta. Este es tu codigo: "+user.act_code)
  end

  def reenviar_pswd(user)
    mail(:to => user.email, :subject => "Recordatorio de pswd", :body => "Recuerda! Tu password es: "+user.password)
  end

  def contact_email(name,email,body)
    mail(:to => "aneu@uniandes.edu.co", :subject => "Contacto - ANEEU", :body => "Nombre: "+name+"\n\nCorreo: "+email+"\n\nMensaje:\n"+body)
  end

  def reclut_email(name,career,semester,area,coments)
    mail(:to => "aneu@uniandes.edu.co", :subject=>"Reclutamiento", :body => "Nombre: "+name+"\n\nCarrera: "+
    career+"\n\nSemestre: "+semester+"\n\nArea de interes: "+area+"\n\nComentarios: \n"+coments)
  end
end
