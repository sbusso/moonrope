controller :users do

  #
  # Specify an action to execute before all methods in this controller.
  #
  before do
    set_header 'X-Hello', 'World'
  end
  
  action :list do
    
    #
    # Set a description for the action including what it does and how
    # it works.
    #
    description "Lists all users in the application"
    
    # 
    # Set any params which are supported by this action.
    #
    param :page, "The current page number for pagination.", :default => 1
    
    #
    # Set the access condition required to access this action.
    #
    access { auth.is_a?(User) }
    
    #
    # Define what actually happens when a user calls this action. It must
    # return a JSON-able object - a string, array or hash.
    #
    action do
      set_flag :pagination, {:page => params['page'], :offset => 0, :total_records => 100, :total_pages => 4}
      []
    end
    
  end
  
  action :info do
    description "Return all information about a given user"
    param :user, "The ID of the user you wish to view"
    access { auth.is_a?(User) }
    action do
      # If the user is 'teapot' set the HTTP status to 418 and add some 
      # headers to say hello
      if params['user'] == 'teapot'
        error :validation_error, [{:field => 'name', :message => 'must be present'}]
      end
      
      if params['user'] == 'notfound'
        error :not_found, "No user found matching 'not_found'"
      end
      
      # Create a new user object to return
      user = User.new
      user.id = 1
      user.username = 'adamcooke'
      user.name = 'Adam Cooke'
      user.date_of_birth = Time.at(515286000)
      user.private_code = 12345
      user.admin = false
      
      # Return a new structure for the user which we created earlier
      structure :user, user, :full => true
    end
  end
  
end
