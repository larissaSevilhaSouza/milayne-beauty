# # Create Admin
User.create({
  name: "agencia w3",
  email: "suporte@agenciaw3.digital",
  password: "AgenciaW3#@9114",
  password_confirmation: "AgenciaW3#@9114",
  admin: true,
})
puts "--> Admin criado" 
# Create Banner
# Banner.create([
#   { title: "Construção Civil",
#     subtitle: "Projetos para desenvolvimentop do nosso municipio saindo do papel",     
#     photo: Rails.root.join("db/assets/images/banner-contrução-civil.jpg").open },
#   { title: "Concientização Ambiental",
#     subtitle: "Muito importante a preservação e aumento das florestas",     
#     photo: Rails.root.join("db/assets/images/banner-image-1200x500-natureza.jpg").open },
# ])
# puts "--> Banners criados"
# # Create About
 About.create([
   { 
     sumary: "Prazer, Milaine  Maraci",
     text: "Fui consagrada para isso e muito mais,levar beleza e autoestima para o mundo 🌍",
     photo: Rails.root.join("db/assets/images/milaine.jpeg").open
   }
 ])
#  puts "--> About criado"
## Create CategoryFonts
category_font_1 = CategoryFont.create({
  title: "Poppins"
})

category_font_2 = CategoryFont.create({
  title: "Poppins"
})

## Create FontPrimaries
FontPrimary.create([
  {
    category_font_id: category_font_1.id
  }
])

## Create FontSecondaries
FontSecondary.create([
  {
    category_font_id: category_font_2.id
  }
])

# puts "--> CategoryFonts, FontPrimaries e FontSecondaries criados"
# Create Album Categories
album_categories = AlbumCategory.create([
  { name: "Cidade" },
  { name: "festa"  },
  { name: "Igreja"  }
])
puts "--> Album Categories criados"

# Create Albums
albums = Album.create([
  { title: "Jateí", date_publish: DateTime.now - 1.year, description: "A cidade maravilhosa!", slug: "jatei", featured: true, album_category: album_categories[0] },
  { title: "Festa da fogueira", date_publish: DateTime.now - 6.months, description: "A maior festa de jateí ms.", slug: "festa-da-fogueira", featured: true, album_category: album_categories[1] },
  { title: "Cavalgada", date_publish: DateTime.now - 6.months, description: "Tradição da cavalgada da fogueira", slug: "cavalgada", featured: true, album_category: album_categories[1] },
  { title: "Igreja santo antonio é inaugurada", date_publish: DateTime.now - 6.months, description: "Igreja santo antonio é inaugurada no centro", slug: "igreja-santo-antonio-e-inaugurada", featured: true, album_category: album_categories[2] }
])
puts "--> Albums criados"

# Create Photos
photos = [
  { image_path: Rails.root.join("db/assets/images/jatei.jpg"), album: albums.first },
  { image_path: Rails.root.join("db/assets/images/jatei-ms.jpg"), album: albums[1] },
  { image_path: Rails.root.join("db/assets/images/jateifogueira24.jpg"), album: albums[1] },
  { image_path: Rails.root.join("db/assets/images/cavalgada.jpg"), album: albums[2] },
  { image_path: Rails.root.join("db/assets/images/igreja.jpg"), album: albums.last }
].map do |photo_attrs|
  photo = Photo.new(album: photo_attrs[:album])
  photo.image = photo_attrs[:image_path].open
  photo.save
  photo
end
# puts "--> Photos criados"
 
 
# # Create SocialMedium
SocialMedium.create([
  { facebook: "http://facebook.com/example", instagram: "http://instagram.com/example", whatsapp: "1234567890" }
])
# puts "--> Social Medium criado"

# # Create Videos
# videos = Video.create([
#   { title: "Jateí", date_publish: DateTime.now - 1.month, url: "https://youtu.be/yAwY2dZ-jv0?si=7uneSbpraxkUzyOn", description: "Conhecendo Jateí MS.", slug: "jatei", featured: true },
#   { title: "Conhecendo Jatei", date_publish: DateTime.now - 3.months, url: "https://youtu.be/f740MjMOxXU?si=o6g9BY4Ei-CJCn47", description: "Jateí-MS", slug: "conhecendo-jatei", featured: true },
#   { title: "Jatei", date_publish: DateTime.now - 3.months, url: "https://youtu.be/hJ0W13yfmBE", description: "Jateí-MS", slug: "jatei", featured: true }
# ])
# puts "--> Videos criados"
# # db/seeds.rb

# # Create SiteColor
 SiteColor.create(
   primary: "#0E345E", 
   sencondary: "#F1F1F1", 
   terciary: "#777777",
   logo_header: File.open(Rails.root.join('db/assets/images/logoheader.png')),
   logo_footer: File.open(Rails.root.join('db/assets/images/logoheader.png'))
 )
#  puts "--> Cores do site e logos criadas"

 