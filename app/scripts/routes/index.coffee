PopHealth.IndexRoute = Ember.Route.extend
  setupController: (controller) ->
    user = @get 'currentUser'
    measureIds = user.get('preferences').selected_measure_ids
    categories = @get('store').all 'category' # don't request from server
    controller.set 'categories', categories
    controller.set 'user', user
    console.log 'bam?'
    # controller.set 'selectedCategories', categories#.filter (category) ->
      # console.log arguments, category.get('name')
      # category.get('measures').any (measure) ->
      #   console.log measure.get('hqmfId')
      #   measureIds.contains measure.get('hqmfId')
