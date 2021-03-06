class Permission < Struct.new(:user, :request)
  def login_required?
    params = request.params
    controller = params[:controller]
    action = params[:action]
    
    return true if controller.in?(%w(addresses confirm connections contacts emails first_names invitations last_names privacy profiles requests))
    return true if controller == "sessions" && action.in?(%w(destroy))
    return true if controller == "users" && action.in?(%w(show edit update destroy))    
  end

  def allow?
    params = request.params
    controller = params[:controller]
    action = params[:action]

    #addresses controller
    if user
      return true if controller == "addresses" && action.in?(%w(index new create))
      if controller == "addresses" && action.in?(%w(show edit update destroy))
        return true if user.contacts.select{|contact| contact.id.to_s == params[:contact_id]}.first.addresses.map(&:id).map(&:to_s).include?(params[:id])
      end
    end
    
    #confirm controller
    if user
      return true if controller == "confirm" && action.in?(%w(email))
    end
    
    #connections controller
    if user
      return true if controller == "connections" && action.in?(%w(index))
    end
    
    #contacts controller
    if user
      return true if controller == "contacts" && action.in?(%w(index new create myinfo))
      if controller == "contacts" && action.in?(%w(show edit update destroy))
        return true if Contact.find(params[:id]).user == user
      end
    end

    #emails controller
    if user
      return true if controller == "emails" && action.in?(%w(index new create))
      if controller == "emails" && action.in?(%w(show edit update destroy))
        return true if user.contacts.select{|contact| contact.id.to_s == params[:contact_id]}.first.emails.map(&:id).map(&:to_s).include?(params[:id])
      end
    end

    #first_names controller
    if user
      return true if controller == "first_names" && action.in?(%w(index new create))
      if controller == "first_names" && action.in?(%w(show edit update destroy))
        return true if user.contacts.select{|contact| contact.id.to_s == params[:contact_id]}.first.first_names.map(&:id).map(&:to_s).include?(params[:id])
      end
    end
      
    #invitations controller  
    if user
      return true if controller == "invitations" && action.in?(%w(index create destroy))
    end 

    #last_names controller
    if user
      return true if controller == "last_names" && action.in?(%w(index new create))
      if controller == "last_names" && action.in?(%w(show edit update destroy))
        return true if user.contacts.select{|contact| contact.id.to_s == params[:contact_id]}.first.last_names.map(&:id).map(&:to_s).include?(params[:id])
      end
    end
    
    #pages controller
    return true if controller == "pages" && action.in?(%w(home))
    
    #privacy controller
    if user
      return true if controller == "privacy" && action.in?(%w(edit update))
    end

    #profiles controller
    if user
      return true if controller == "profiles" && action.in?(%w(index new create show edit update destroy))
    end
    
    #requests controller
    if user
      return true if controller == "requests" && action.in?(%w(index update destroy))
    end
    
    #sessions controller
    if user
      return true if controller == "sessions" && action.in?(%w(destroy))
    else
      return true if controller == "sessions" && action.in?(%w(new))
    end    

    #users controller
    if user
      return true if controller == "users" && action.in?(%w(show edit update destroy))
    else
      return true if controller == "users" && action.in?(%w(new create))
    end
    
    #all other requests
    return false
  end
end
