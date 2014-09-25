PopHealth = window.PopHealth = Ember.Application.create
  customEvents:
    'show.bs.collapse': 'showCollapse'
    'hidden.bs.collapse': 'hideCollapse'


require 'scripts/helpers'
require 'scripts/controllers/*'
require 'scripts/store'
require 'scripts/models/*'
require 'scripts/routes/*'
require 'scripts/components/*'
require 'scripts/views/*'
require 'scripts/router'
