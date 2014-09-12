PopHealth.IndexController = Ember.Controller.extend
  selectedCategories: (->
    categories = @get('categories')
    user = @get('user')
    measureIds = user.get('preferences').selected_measure_ids
    console.log 'Controller', categories
    categories.filter (category) ->
      console.log category.get('name')
      category.get('measures').any (measure) ->
        console.log 'x', measure.get('hqmfId')
        measureIds.contains measure.get('hqmfId')
  ).property('user.preferences', 'categories.@each.measures.@each.hqmfId')
