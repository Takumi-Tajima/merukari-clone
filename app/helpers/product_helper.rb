module ProductHelper
  def product_image_tag(product, variant, options = {})
    if product.image.attached?
      default_options = { alt: product.name, class: 'img-fluid rounded' }
      image_tag product.image.variant(variant), default_options.merge(options)
    else
      no_image_class = options[:no_image_class] || 'd-flex align-items-center justify-content-center bg-secondary text-white'
      style = variant == :display ? 'height: 400px;' : 'height: 200px;'
      content_tag :div, 'No Image', class: no_image_class, style: style
    end
  end
end
