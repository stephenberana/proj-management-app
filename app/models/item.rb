class Item < ApplicationRecord
  before_save :upload_to_s3
  attr_accessor :upload
  belongs_to :project
  belongs_to :task


  def upload_to_s3
    s3 = Aws::S3::Resource.new(
    region: 'us-east-2',
    force_path_style: true,
    signature_version: 'v4',
    credentials: Aws::Credentials.new(
        'AKIA4Q7PEMGPNOICLAYR',
        'WPy3Ax8b+gJJrEOQtY1gzYT+FxyzblVHy+yFxhPf'
    )
)

    org =  User.find(ActsAsTenant.current_tenant.id).organization.name
    obj = s3.bucket("proj-management-app").object("#{org}/#{upload.original_filename}")
    obj.upload_file(upload.path, acl:'public-read', content_type:"")
    self.key = obj.public_url
  end

end
