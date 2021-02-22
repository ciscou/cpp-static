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
proxy "/contacte-con-nosotros/index.html", "/contact.html", ignore: true

data.categories.each do |category|
  category_name = category["es_name"]
  category_param = [category["id"], category_name.parameterize].join("-")
  proxy "/catalogo/#{category_param}/productos/index.html", "/category_products.html", locals: { category: category }, ignore: true
end

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

helpers do
  def category_name(category)
    category["es_name"]
  end

  def category_description(category)
    category["es_description"]
  end

  def category_slug(category)
    category_name(category).parameterize
  end

  def category_param(category)
    [category.id, category_slug(category)].join("-")
  end

  def product_name(product)
    product["es_name"]
  end

  def product_description(product)
    product["es_description"]
  end

  def product_slug(product)
    product_name(product).parameterize
  end

  def product_param(product)
    [product.id, product_slug(product)].join("-")
  end

  def new_arrivals
    data.categories.flat_map do |category|
      data["category_#{category["id"]}_products"]
    end.select do |product|
      product["new_arrival"]
    end.sort_by do |product|
      product["created_at"]
    end
  end
end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
end
