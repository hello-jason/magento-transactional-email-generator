# ========================================================================
# Hello Jason
# http://hellojason.net
# ========================================================================

# Copy ./source/environment_variables.example to ./source/environment_variables.rb
# then update settings there.
require "./source/environment_variables.rb"

# ========================================================================
# Site settings
# ========================================================================
set :site_title,           "Sweets & Treats"
set :site_description,     "The leading source of greaseproof cupcake liners"
set :site_url_production,  ENV['site_url_production']
set :site_url_development, ENV['site_url_development']

# Set asset directories
set :css_dir,              "assets/css"
set :images_dir,           "assets/img"

# Sitemap URLs (use trailing slashes). Create additional variables here
# for referencing your pages.
set :url_home,                       "/"

# ========================================================================
# Magento template variables
# ========================================================================
set :magento_billing_address, "{{var order.getBillingAddress().format('html')}}"
set :magento_payment_html, "{{var payment_html}}"
set :magento_order_id, "{{var order.increment_id}}"
set :magento_created_at_long, "{{var order.getCreatedAtFormated('long')}}"
set :magento_support_email, "{{config path='trans_email/ident_support/email'}}"

# Slim template engine
require "slim"

# Use relative URLs
activate :relative_assets

# Autoprefixer
activate :autoprefixer do |config|
  config.browsers = ['last 2 versions', 'Explorer >= 9']
  config.cascade  = false
  config.inline   = false
end

# Pretty URLs
activate :directory_indexes

# ========================================================================
# Helpers
# ========================================================================
helpers do
  # Returns all pages under a certain directory.
  def sub_pages(dir)
    sitemap.resources.select do |resource|
      resource.path.start_with?(dir)
    end
  end
end

# ========================================================================
# Development-specific configuration
# ========================================================================
configure :development do
  set :site_url, "#{site_url_development}"

  # Reload the browser automatically whenever files change
  activate :livereload
end

# ========================================================================
# Build-specific configuration
# ========================================================================
configure :build do
  # Ignore file/dir during build process
  ignore ".git"
  ignore "environment_variables.rb"
  ignore "environment_variables.rb.sample"

  set :site_url, "#{site_url_production}"

  # Optimization
  set :sass, line_comments: false, style: :compressed
  activate :minify_css
  # activate :minify_html

  # Cache buster
  # activate :asset_hash, :exts => ['.css', '.png', '.jpg', '.gif']

  # Compress and optimise images during build
  # Documentation: https://github.com/plasticine/middleman-imageoptim
  activate :imageoptim do |options|
    # Use a build manifest to prevent re-compressing images between builds
    options.manifest = false
    # Image extensions to attempt to compress
    options.image_extensions = %w(.png .jpg .gif .svg)
    # Cause image_optim to be in shouty-mode
    options.verbose = false
  end

end

# ========================================================================
# Deploy-specific configuration
# Documentation: https://github.com/middleman-contrib/middleman-deploy
# ========================================================================
case ENV['TARGET'].to_s.downcase
  #
  # rake deploy:production
  #
  when 'production'
    activate :deploy do |deploy|
      deploy.build_before = false # build happens in rake task
      deploy.method = :git
      deploy.remote   = 'origin'
      deploy.branch   = 'gh-pages'
      deploy.strategy = :force_push
    end
  #
  # rake deploy:staging
  #
  when 'staging'
    activate :deploy do |deploy|
      deploy.build_before = false # build happens in rake task
      deploy.method = :git
      deploy.remote   = 'origin'
      deploy.branch   = 'staging'
      deploy.strategy = :force_push
    end
  end
