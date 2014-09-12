PopHealth.IndexController = Ember.ArrayController.extend
  itemController: 'category'
  selectedCategories: (->
    categories = @get('model')
    user = @get('user')
    measureIds = user.get('preferences').selected_measure_ids
    console.log 'Controller', categories
    categories.filter (category) ->
      console.log category.get('name')
      category.get('measures').any (measure) ->
        measureIds.contains measure.get('hqmfId')
  ).property('user.preferences', 'categories.@each.measures.@each.hqmfId')

PopHealth.CategoryController = Ember.ObjectController.extend
  isSelected: ( ->
    user = @get 'currentUser'
    measureIds = user.get('preferences').selected_measure_ids
    category = @get 'model'
    category.get('measures').any (measure) -> measureIds.contains measure.get('hqmfId')
  ).property()
