PopHealth.IndexRoute = Ember.Route.extend
  setupController: (controller) ->
    user = @get 'currentUser'
    measureIds = user.get('preferences').selected_measure_ids
    categories = @get('store').all 'category' # don't request from server
    controller.set 'model', categories
    controller.set 'user', user
