class Product < ActiveRecord::Base
  belongs_to :categories
  has_many :order_details
  validates :product_name, presence: true
  has_many :comments

  validates :price, presence: true
  validates :description, presence: true, length: {maximum: 150}
  validates :quantity, presence: true
  validates :rating, presence: true
  validate :images_size

  scope :product_name,
    ->(product_name){where("product_name LIKE ?", "%#{product_name}%")}
  scope :price,
    ->(price){where("price = ?", "#{price}")}

  private
  def images_size
    if self.images.size > Settings.admin.products.images_size.megabytes
      errors.(add :images, t("models.products.validate_images"))
    end
  end
end
