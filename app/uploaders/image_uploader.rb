class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # 이미지 편집 프로그램(이미지 사이즈 제한> 용량 줄이기 위해)
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # 이미지를 저장하는 프로그램 uploader.
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end
  
  #원본이미지 사이즈 지정
  process resize_to_limit: [900, 900]
  
  # Create different versions of your uploaded files:
  # 썸네일 버전 이미지 사이즈 지정
  version :thumb do
    process resize_to_fill: [200, 200]
    # resize_to_fit
    # resize_to_fill
    # resize_to_limit
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  #이미지 파일이 아니었을 때 경고
  def extension_whitelist
     %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
