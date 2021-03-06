class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  # :database_authenticatable, :registerable, :recoverable
  devise :openid_authenticatable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  # :password, :password_confirmation,
  attr_accessible :email, :remember_me, :identity_url
  
  def self.create_from_identity_url(identity_url)
    self.create(:identity_url => identity_url)
  end
  
  def self.openid_required_fields
    ["email", "http://axschema.org/contact/email"]
  end
  
  def openid_fields=(fields)
    fields.each do |key, value|
      # Some AX providers can return multiple values per key
      if value.is_a? Array
        value = value.first
      end

      case key.to_s
        when "email", "http://axschema.org/contact/email"
          self.email = value
        else
          logger.error "Unknown OpenID field: #{key}"
      end
    end
  end
  
  has_many :questions,  :dependent => :destroy
  has_many :answers,    :dependent => :destroy
  has_one :profile,     :dependent => :destroy
  
  # some scopes
  scope :rp,      order("reputation DESC")
  scope :oldest,  order("created_at ASC")
  
  # vote plugin
  acts_as_voter
  has_karma(:questions, :as => :user)
  
  # gravatar plugin
  is_gravtastic!
  
  # create a profile after user sign up
  after_create :create_profile
  
  private
    def create_profile
      self.profile ||= Profile.new(:first_name => "无名", :last_name => "氏")
      self.save
    end
    
end
