module Spree
  class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :token_authenticatable, :confirmable,
    # :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

    has_one :shop, class_name: 'Spree::Shop'
    has_many :listings, through: :shop

    roles_table_name = Role.table_name
    scope :registered, -> { where("#{users_table_name}.email NOT LIKE ?", "%@example.net") }

    class << self
      def anonymous!
        token = User.generate_token(:persistence_token)
        User.create(:email => "#{token}@example.net", :password => token, :password_confirmation => token, :persistence_token => token)
      end
    end

    def anonymous?
      email =~ /@example.net$/ ? true : false
    end

  end
end