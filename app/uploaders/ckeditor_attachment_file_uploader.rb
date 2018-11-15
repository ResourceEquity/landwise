# encoding: utf-8
require 'carrierwave'

class CkeditorAttachmentFileUploader < CarrierWave::Uploader::Base

  include Ckeditor::Backend::CarrierWave

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    Ckeditor.attachment_file_types
  end

end
