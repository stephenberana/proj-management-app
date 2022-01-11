class Item < ApplicationRecord
  before_save :upload_to_s3
  attr_accessor :upload
  belongs_to :project


  def upload_to_s3
    s3 = Aws::S3::Resource.new(region:'us-east-2')
    org =  User.find(ActsAsTenant.current_tenant.id).organization.name
    obj = s3.bucket(ENV['S3_BUCKET']).object("#{org}/#{upload.original_filename}")
    obj.upload_file(upload.path, acl:'public-read', content_type:"")
    self.key = obj.public_url
  end

end
