class Role

  ROLES = {
      superadmin: 1,
      regular_user: 2
  }

  def self.types
    ROLES
  end
end
