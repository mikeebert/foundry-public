class MockUser
  attr_accessor :admin, :id, :name, :email, :received_params

  def create(params)
    @received_params = params
    return self
  end
  
  def apprenticeships
    []
  end
  
  def admin?
    @admin == true
  end
  
  def save
    
  end
end
