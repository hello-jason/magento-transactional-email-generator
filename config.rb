# ========================================================================
# Hello Jason
# http://hellojason.net
# ========================================================================

# Copy ./source/environment_variables.example to ./source/environment_variables.rb
# then update settings there.
require "./source/environment_variables.rb"

# Slim template engine
require "slim"

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

# ========================================================================
# Magento template variables
# ========================================================================
# Customer
set :magento_customer_name, "{{htmlescape var=$order.getCustomerName()}}"
set :magento_billing_address, "{{var order.getBillingAddress().format('html')}}"
# Order
set :magento_order_id, "{{var order.increment_id}}"
set :magento_order_status, "{{var order.getStatusLabel()}}"
set :magento_created_at_long, "{{var order.getCreatedAtFormated('long')}}"
set :magento_credit_memo_id, "{{var creditmemo.increment_id}}"
# Invoices
set :magento_invoice_id, "{{var invoice.increment_id}}"
# Links
set :magento_payment_html, "{{var payment_html}}"
set :magento_account_url, "{{store url='customer/account/'}}"
set :magento_password_reset_url, "{{store url='customer/account/resetpassword/' _query_id=$customer.id _query_token=$customer.rp_token}}"
# Store
set :magento_store_name, "{{var store.getFrontendName()}}"
set :magento_support_email, "{{config path='trans_email/ident_support/email'}}"

# ========================================================================
# Other settings
# ========================================================================

# Use relative URLs
activate :relative_assets

# Autoprefixer
activate :autoprefixer do |config|
  config.browsers = ['last 2 versions', 'Explorer >= 9']
  config.cascade  = false
  config.inline   = false
end

# Pretty URLs
#activate :directory_indexes

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
