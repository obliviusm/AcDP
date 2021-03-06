class User < ActiveRecord::Base
  devise :database_authenticatable

  validates_presence_of   :login
  validates_uniqueness_of :login

  validates_format_of     :email, :with  => Devise.email_regexp, :allow_blank => true, :if => :email_changed?

  validates_length_of       :password, within: Devise.password_length, :if => :password_required?
  validates_presence_of     :password, :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  ROLES = %w[student worker teacher admin]

  def roles=(roles)
    self.role = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def add_role(role)
    self.roles = roles + [role]
  end

  def remove_role(role)
    self.roles = roles - [role]
  end

  def has_role?(role)
    roles.include?(role.to_s)
  end

  def roles
    ROLES.reject do |r|
      ((role.to_i || 0) & 2**ROLES.index(r)).zero?
    end
  end
end
