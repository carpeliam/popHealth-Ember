PopHealth.SidebarCategoryView = Ember.View.extend
  showCollapse: ->
    controller = @get 'controller'
    controller.set 'isOpen', yes
  hideCollapse: ->
    controller = @get 'controller'
    controller.set 'isOpen', no
