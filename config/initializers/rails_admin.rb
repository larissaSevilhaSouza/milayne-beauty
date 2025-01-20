require 'rails_admin/config/actions/rails_admin_drop_zone'
require 'diff/lcs'
RailsAdmin.config do |config|
  config.main_app_name = ["Prefeitura de Jateí", ""]
  config.asset_source = :sprockets

  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user) 
  
  ## == Cancan ==
  config.authorize_with :cancancan
  
  config.actions do
  
  config.model 'User' do
    navigation_icon 'fa-solid fa-users'
    navigation_label 'Usuários' 
    list do
      field :id
      field :name
      field :email 
      field :admin 
    end
    edit do 
      field :name
      field :email
      field :password
      field :password_confirmation
      field :admin do
        visible do
          bindings[:view]._current_user.admin?
        end
      end
    
    end
  end
  ### quick_access_view ###
  config.model 'QuickAccessView' do
    visible false
 end
 
  ### Permissao ###
  config.model 'Permission' do
     visible false
  end
  
  config.model "FormatAd" do 
    visible false
    list do
      field :id       
      field :title    
      field :width
      field :height
      field :position
    end
  end
  
  config.model 'Banner' do 
    navigation_icon 'fa-solid fa-image'
    navigation_label 'Banners'
    list do
      field :id       
      field :title    
      field :format_ad
    end
    edit do
      field :category, :enum do
        default_value "Video"
      end
      field :format_ad, :belongs_to_association do
        inline_add false
        inline_edit false
      end
      field :title
      field :subtitle      
      field :photo do
        visible? do
          bindings[:object].category == "Foto"
        end
      end
      field :video do
        visible? do
          bindings[:object].category == "Video"
        end
      end
      field :link      
      field :status  
    end    
  end

  #about
  config.model 'About' do   
    navigation_icon 'fa-solid fa-circle-info'
    navigation_label 'Sobre nós'
    list do
      field :id       
      field :sumary        
    end
    edit do
      field :sumary     
      field :text, :wysihtml5
      field :photo     
    end    
  end

  config.model 'Oxoplastium' do    
    navigation_label 'Oxoplastia'
    list do
      field :id       
      field :text      
    end
    edit do     
      field :text, :wysihtml5
      field :photo     
      field :gallery_oxes     
    end    
  end

  config.model 'GalleryOx' do    
    visible false
    list do
      field :id             
    end
    edit do       
      field :photo     
    end    
  end
 

   
  #redes sociais
  config.model 'SocialMedium' do 
    navigation_icon 'fa-solid fa-hashtag'
    navigation_label 'Configurações'
    list do
      field :id       
      field :whatsapp
    end
    edit do
      field :whatsapp
      field :instagram
      field :facebook 
      field :insta_show
    end    
  end
  
  #contatos
  config.model 'Contact' do 
    navigation_icon 'fa-solid fa-phone'
    navigation_label 'Contatos do site'
    list do
      field :id       
      field :name
      field :email
      field :subject
    end
    edit do
      field :name
      field :email
      field :phone
      field :subject
      field :message
    end    
  end
  
   #adjustment
   config.model 'Adjustment' do   
      navigation_icon 'fa-solid fa-gears'
      navigation_label 'Configurações'
       list do
         field :id       
         field :phone     
       end
       edit do
         field :phone     
         field :adress
         field :email
     end
   end
 
       #Audit
    config.model 'Audit' do 
      navigation_icon 'fa-solid fa-marker'
      navigation_label 'Configurações'
    
      list do
        field :id       
        field :user
        field :auditable_type do
          pretty_value do
            I18n.t("actions.#{value}")
          end
        end
        field :action do
          pretty_value do
            I18n.t("actions.#{value}")
          end
        end
        field :created_at do
          formatted_value do
            value.in_time_zone('Brasilia').strftime('%d/%m/%Y'  +' ás '+  '%H:%M')
          end
        end
      end
    
      show do 
        field :user_id   
        field :user
        field :auditable_type do
          pretty_value do
            I18n.t("actions.#{value}")
          end 
        end
        
        field :audited_changes do
          formatted_value do 
            return '' if value.blank?
            changes_hash = YAML.safe_load(value, permitted_classes: [Date])        
            return '' unless changes_hash.is_a?(Hash)
            
            formatted_changes = case bindings[:object].action
            when 'create'
              changes_hash.map do |attribute, new_value|
                translated_attribute = I18n.t("activerecord.attributes.#{bindings[:object].auditable_type.underscore}.#{attribute}", default: attribute.humanize)
                formatted_value = new_value.is_a?(Date) || new_value.is_a?(Time) ? I18n.l(new_value, format: :long) : new_value
                "#{translated_attribute}: #{formatted_value}"
              end.join("<br />").html_safe
        
            when 'update'
              changes_hash.map do |attribute, changes| 
                translated_attribute = I18n.t("activerecord.attributes.#{bindings[:object].auditable_type.underscore}.#{attribute}", default: attribute.humanize)
                changes = [changes] unless changes.is_a?(Array) 
                next unless changes.size >= 2 
        
                old_text = changes.first.to_s.dup
                new_text = changes.last.to_s.dup
        
                old_text = I18n.l(old_text, format: :long) if old_text.is_a?(Date) || old_text.is_a?(Time)
                new_text = I18n.l(new_text, format: :long) if new_text.is_a?(Date) || new_text.is_a?(Time)
        
                added_words = new_text.split - old_text.split
                removed_words = old_text.split - new_text.split
        
                removed_words.each { |word| old_text.gsub!(word, "<span style='color:red;'>#{word}</span>") }
        
                if added_words.any?
                  added_words.each { |word| new_text.gsub!(word, "<span style='color:green;'>#{word}</span>") }
                end
        
                "#{translated_attribute}: #{old_text} -> #{new_text}"
              end.compact.join("<br />").html_safe
        
            when 'destroy'
              changes_hash.map do |attribute, old_value|
                translated_attribute = I18n.t("activerecord.attributes.#{bindings[:object].auditable_type.underscore}.#{attribute}", default: attribute.humanize)
                formatted_value = old_value.is_a?(Date) || old_value.is_a?(Time) ? I18n.l(old_value, format: :long) : old_value
                "#{translated_attribute}: #{formatted_value} (Excluído)"
              end.join("<br />").html_safe
        
            else
              ""
            end
        
            formatted_changes
          end
        end
        field :created_at do
          formatted_value do
            I18n.l(value.in_time_zone('Brasilia'), format: :long)
          end
        end 
        field :remote_address
      end
    end
        
    config.model 'Adsense' do 
      navigation_icon 'fa-solid fa-code'
      navigation_label 'Configurações'
      list do
        field :id       
        field :title
        field :ad_type 
      end
      edit do
        field :title
        field :ad_type 
        field :script
        field :status
      end    
   end
      
    
  ### PostView ###
  config.model "PostView" do
    visible false
    list do
      field :id 
    end 
  end
    
  ### PostCategory ###
  config.model "PostCategory" do
    navigation_icon 'fa-solid fa-pencil'
    weight -1
    navigation_label "Imprensa"
    list do
      field :id
      field :name
    end
    edit do
      field :name
    end
  end

  ### Post ###
  config.model "Post" do
    navigation_icon 'fa-solid fa-newspaper'
    navigation_label "Imprensa" 
    list do
      field :id
      field :title
      field :post_category
      field :is_published
      field :post_views_count 
      field :featured
    end
    create do
      field :title
      field :summary
      field :written_by
      field :source
      field :cover
      field :post_category do
        inline_add false
        inline_edit false
      end
      field :date_publish 
      field :is_published
      field :content do
        partial "add_content"
      end
      field :featured
    end
    edit do
      field :title
      field :summary
      field :written_by
      field :cover
      field :post_category do
        inline_add false
        inline_edit false
      end
      field :date_publish
      field :is_published
      field :content do
        html_attributes do
          { "data-ckeditor": true }
        end
      end
      field :album do
        inline_add false
      end
      field :featured
  end
  ### Album Category ###
  config.model "AlbumCategory" do
    navigation_icon 'fa-solid fa-folder-open'
    navigation_label "Multimidia"
    list do
      field :id
      field :name
    end
    edit do
      field :name
    end
  end
  
  ### Album ###
  config.model "Album" do
    navigation_icon 'fa-solid fa-images'
    navigation_label "Multimidia"
    list do
      field :id
      field :title
      field :date_publish
      field :featured
      
    end
    edit do
      field :album_category do
        inline_add false
        inline_edit false
      end
      field :title
      field :date_publish
      field :photos
      field :description, :wysihtml5
      field :featured
    end
    create do
      field :album_category  do
        inline_add false
        inline_edit false
      end
      field :title
      field :date_publish
      field :photos
      field :description, :wysihtml5
      field :featured
    end
  end

  ### Photos ###
  config.model "Photo" do  
    visible false
    list do 
      field :id
      field :image
    end
    edit do
      field :image
      field :cover
    end
  end
  
  ### Post Image ###
  config.model "PostImage" do  
    visible false
    list do 
      field :id
      field :url
    end
    edit do
      field :url
      field :post
    end
  end
  
  
   ### Video ###
   config.model "Video" do
    navigation_icon 'fa-solid fa-video'  
    navigation_label "Multimidia"
    list do
      field :id
      field :title
      field :date_publish
    end
    create do
      field :title
      field :date_publish
      field :url
      field :description, :wysihtml5
      field :featured
    end
    edit do
      field :title
      field :date_publish
      field :url
      field :description, :wysihtml5
      field :featured
    end
  end
  
  
   ### link Top ###
   config.model "LinkTop" do
    navigation_icon 'fa fa-link'
    navigation_label "Links do topo"
    list do
      field :id
      field :name
      field :icon
    end
    edit do
      field :name
      field :icon
      field :link
      field :new_page
    end
  end
  
   #menu
  config.model 'Menu' do
    navigation_icon 'fa fa-bars'  
    navigation_label 'Menu' 
    list do
      field :id
      field :name
      field :ordem
      field :active_link
      field :active_sub_menu
      field :sub_menus do
        pretty_value do
          value.map { |v| v.name }.join(', ')
        end
      end
    end
    create do 
      field :name
      field :ordem
      field :active_link
      field :link 
      field :active_sub_menu
      field :sub_menus 
      field :active
    end
    edit do 
      field :name
      field :ordem
      field :active_link
      field :link 
      field :active_sub_menu
      field :sub_menus 
      field :active
    end
  end
    
  #sub menu
    config.model "SubMenu" do 
      visible false
      list do
        field :id
        field :name 
      end
      create do
        field :name
        field :link 
        field :new_page
      end
      create do
        field :name
        field :link 
        field :new_page
      end
      edit do
        field :name
        field :link 
        field :new_page
      end
    end 
  
 end
  
  
  ### cores do site ###
  config.model "SiteColor" do
    navigation_icon 'fa fa-palette' 
    navigation_label "Configurações do site"
    list do
      field :id
      field :primary
      field :sencondary
      field :terciary
    end
    edit do
      field :primary
      field :sencondary
      field :terciary
      field :logo_header
      field :logo_footer 
    end
  end
  
  ###  fontes ###
  config.model "CategoryFont" do
    navigation_icon 'fa fa-font' 
    navigation_label "Configurações do site"
    list do
      field :id
      field :title
    end
    edit do
      field :title
    end
  end
  
   ###  fonte primaria ###
   config.model "FontPrimary" do
    navigation_icon 'fa-solid fa-font'   
    navigation_label "Configurações do site"
    list do
      field :id
      field :category_font
    end
    edit do
      field :category_font  do
        inline_add false
        inline_edit false
      end
    end
  end
    
  ###  fonte secundaria ###
  config.model "FontSecondary" do
    navigation_icon 'fa fa-text-height'     
    navigation_label "Configurações do site"
    list do
      field :id
      field :category_font 
    end
    edit do
      field :category_font do
        inline_add false
        inline_edit false
      end
    end
  end
       
 
  config.model 'ItemStory' do
    navigation_label 'Loja' 
    list do
      field :id
      field :name
      field :description
      field :category_store
      field :created_at
    end
    edit do
      field :name
      field :description
      field :category_store
      field :photo_itens
    end
  end

  # Configuration for CategoryStore
  config.model 'CategoryStore' do
    navigation_label 'Loja' 
    list do
      field :id
      field :name 
    end
    edit do
      field :name
    end
  end

  config.model 'PhotoIten' do
    visible false  
    list do
      field :id
      field :photo 
    end
    edit do
      field :photo 
    end
  end
  
  config.model 'Store' do
    navigation_label 'Loja' 
    list do
      field :id
      field :name
      field :description
    end
    edit do
      field :name
      field :image
      field :text
      field :description
    end
  end

  config.model 'ScheduleYourAppointment' do
    navigation_label 'Agende seu horário' 
    list do
      field :id 
      field :description
    end
    edit do
      field :photo
      field :description, :wysihtml5
      field :number
    end
  end
  

  dashboard                    
  index                        
  new do
    except ['Contact', '', '', 'Audit']
  end
  export
  bulk_delete
  show_in_app do
    except ['Contact']
  end
  show do
    only ['Contact', 'Audit']
  end
  edit do
    except ['Contact', 'Audit']
  end
  delete do
    except ['Contact', 'Audit']
  end

  drop_zone do
    only ["Album"]
  end

  end
end