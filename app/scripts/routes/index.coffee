PopHealth.IndexRoute = Ember.Route.extend
  setupController: (controller) ->
    controller.set 'model', @get('store').all('category') # don't request from server
