PopHealth.SidebarCategoryView = Ember.View.extend
  classNames: ['panel', 'panel-default']
  showCollapse: ->
    controller = @get 'controller'
    controller.set 'isOpen', yes
  hideCollapse: ->
    controller = @get 'controller'
    controller.set 'isOpen', no
