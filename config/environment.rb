# encoding:utf-8
# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Guaguale::Application.initialize!

# Modify at 2012-06-16
require 'will_paginate'
# will_paginate custom label
WillPaginate::ViewHelpers.pagination_options[:previous_label] = '« 上一页'
WillPaginate::ViewHelpers.pagination_options[:next_label] = '下一页 »'
