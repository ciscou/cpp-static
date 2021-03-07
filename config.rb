# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

activate :directory_indexes

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

proxy "/catalogo/index.html", "/catalog.html", ignore: true
proxy "/quienes-somos/index.html", "/who.html", ignore: true
proxy "/donde-estamos/index.html", "/where.html", ignore: true
proxy "/contacto/index.html", "/contact.html", ignore: true

data.categories.each do |category|
  proxy "/catalogo/#{category.slug}/productos/index.html", "/category_products.html", locals: { category: category, title: category.name }, ignore: true
  category.products.each do |product|
    proxy "/catalogo/#{category.slug}/productos/#{product.id}-#{product.slug}/index.html", "/product.html", locals: { category: category, product: product, title: product.name }, ignore: true
  end
end

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

helpers do
  def new_arrivals
    data.categories.flat_map do |category|
      category.products.each { |p| p.category_id = category.id }
    end.select do |product|
      product.new_arrival
    end.sort_by do |product|
      product.id
    end
  end

  def category_products_path(category)
    "/catalogo/#{category.slug}/productos"
  end

  def category_product_path(category, product)
    "/catalogo/#{category.slug}/productos/#{product.id}-#{product.slug}"
  end

  def category_photo_path(category)
    "category/#{category.id}/#{category.slug}.jpg"
  end

  def product_photo_path(product)
    "product/#{product.id}/#{product.slug}.jpg"
  end

  def product_thumbnail_path(product)
    "product/#{product.id}/thumb/#{product.slug}.jpg"
  end
end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
end
