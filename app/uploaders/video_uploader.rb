class VideoUploader < CarrierWave::Uploader::Base
  include CarrierWave::Vips
  after :store, :transcode_video

  if Rails.env.development? || Rails.env.test?
    storage :file
  else
    storage :sftp
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def filename
    if original_filename.present?
      name = original_filename.gsub(/\.#{file.extension}$/, "")
      name = name.parameterize.truncate(200, omission: "") # limite de 200 caracteres
      "#{name}.#{file.extension}"
    end
  end

  def transcode_video(_file)
    input_path = file.path
    output_path = "#{Rails.root}/public/uploads/#{store_dir}/#{file.basename}.mp4"
    resolution = "640x480"

    # Executando o comando FFmpeg diretamente no shell
    system("ffmpeg -i #{input_path} -vf scale=#{resolution} #{output_path}")
  end

  def extension_white_list
    %w(mp4 mov avi)
  end
end
