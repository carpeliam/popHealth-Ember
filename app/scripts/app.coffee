PopHealth = window.PopHealth = Ember.Application.create
  customEvents:
    'show.bs.collapse': 'showCollapse'
    'hidden.bs.collapse': 'hideCollapse'


# Order and include as you please.
require 'scripts/controllers/*'
require 'scripts/store'
require 'scripts/models/*'
require 'scripts/routes/*'
require 'scripts/components/*'
require 'scripts/views/*'
require 'scripts/router'
