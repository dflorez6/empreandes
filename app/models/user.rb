class User < ActiveRecord::Base
  attr_accessible :admin, :bio, :email, :interest, :name, :oath_expires_at, :oauth_token, :password, :uid, :act_code, :activated, :fb_connected, :estado, :codigo, :programa
  before_save :create_remember_token

  validates_uniqueness_of :email, :message => "Este correo ya tiene asignado una cuenta ANEU."
  validates_uniqueness_of :codigo, :message => "Este codigo estudiantil ya tiene asignado una cuenta ANEU."

  no_whitespace = /^[\S]+$/
  validates_presence_of :email, :password, :message => "Llena todos los datos por favor."
  validates_format_of :email, :with =>  /(@uniandes.edu.co)\Z/, :message => "Recuerda, debes poner todo correo uniandes. Es decir, con @uniandes.edu.co"
  validates_format_of :email,:password, :with => no_whitespace, :message => "No debe haber un espacio en ninguno de los campos."

  def self.search(search)
    if search
      find(:all,:conditions => ['name LIKE ?',"%#{search}%"])
    else
      find(:all)
    end
  end

  def self.from_omniauth(auth)
    where(auth.slice(:uid)).first_or_initialize.tap do |user|
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oath_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

  def create_act_code
    self.act_code= SecureRandom.urlsafe_base64
    self.activated = false
  end
end
