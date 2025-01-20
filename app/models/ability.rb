class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :access, :rails_admin
      can :manage, :all
    else
      can :dashboard, :all
      can :access, :rails_admin
      can :read, :dashboard

      # Permissões para os modelos do RailsAdmin
      if user.permissions.find_by_title("Usuários").present?
        can :manage, User
      end
      
      if user.permissions.find_by_title("Banners").present?
       can :manage, Banner
      end 
      
      if user.permissions.find_by_title("Sobre nós").present?
        can :manage, About
      end
      
      if user.permissions.find_by_title("Multimidia").present?
         can :manage, Video
         can :manage, Album
         can :manage, AlbumCategory
      end
      
      if user.permissions.find_by_title("Contatos do site").present?
         can :manage, Contact
      end
      
      if user.permissions.find_by_title("Leis").present?
        can :manage, LawCategory
        can :manage, Law
      end
     
      if user.permissions.find_by_title("Acesso Rápido").present?
        can :manage, CategoryQuickAccess
        can :manage, QuickAccess
      end
      
      if user.permissions.find_by_title("Imprensa").present?
        can :manage, PostCategory
        can :manage, Post
      end
      
      if user.permissions.find_by_title("Diário Oficial").present?
        can :manage, OfficialDiary
      end
      
      if user.permissions.find_by_title("Links do topo").present?
        can :manage, LinkTop
      end
      
      if user.permissions.find_by_title("Menu").present?
        can :manage, Menu
        can :manage, SubMenu
      end
      
      if user.permissions.find_by_title("Licitação").present?
        can :manage, BidNotice
        can :manage, BiddingCategory
        can :manage, Contract
        can :manage, BidComplete
        can :manage, ContractEnd
        can :manage, BidResult 
     end
      
      if user.permissions.find_by_title("Configurações").present?
        can :manage, Adjustment
        can :manage, SocialMedium
        can :manage, Adsense 
        can :manage, Audit
      end
 
    end
  end
end
