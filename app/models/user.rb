class User < ActiveRecord::Base
  # new columns need to be added here to be writable through mass assignment
  #attr_accessible :username, :email,:password, :password_confirmation
  attr_accessible :name, :email, :phone, :address, :bio
  #attr_accessor :password
  before_save :prepare_password

  validates_presence_of :username
  validates_uniqueness_of :username, :email, :allow_blank => true
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password_hash, :on => :create
  validates_presence_of :password_salt, :on => :create
  #validates_confirmation_of :password
  #validates_length_of :password, :minimum => 4, :allow_blank => true

  validate :username_is_valid

  def username_is_valid
    if self.username == nil; errors.add(:username, "The username was not set.");return; end
    if not self.username.instance_of? String; errors.add(:username, "The username should be a string.");return;end
    if self.username.length < 3 then
      errors.add(:username, "The username must be at least three characters long.")
    end
    user = find_by_username self.username
    if user != self
      errors.add(:username, "The username already exists in the database.")
      return false
    end
  end

  # login can be either username or email address
  def self.authenticate(login, pass)
    user = find_by_username(login) || find_by_email(login)
    return user if user && user.matching_password?(pass)

    #Failure, the username was invalid or the password didn't match.
    flash[:warning] = [[:login, "The given login was not found or the password did not match."]]
    redirect_to logins_path
  end

  def prepare_password
    unless password.blank?
      self.password_salt = Digest::SHA2.hexdigest([Time.now, rand].join)
      self.password_hash = encrypt_password(password)
    end
  end

  def encrypt_password(pass)
    Digest::SHA2.hexdigest([pass, password_salt].join)
  end

  def matching_password?(pass)
    self.password_hash == encrypt_password(pass)
  end
end
