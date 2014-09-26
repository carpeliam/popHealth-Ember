PopHealth.IndexController = Ember.ArrayController.extend
  selectedCategories: ( ->
    categories = @get 'model'
    measureIds = @get 'currentUser.preferences.selected_measure_ids.[]'
    categories.filter (category) ->
      category.get('measures').any (measure) -> measureIds.contains measure.get('hqmfId')
  ).property('currentUser.preferences.selected_measure_ids.[]', '@each.measures.@each.hqmfId')


PopHealth.DashboardCategoryController = Ember.ObjectController.extend
  selectedMeasures: ( ->
    measureIds = @get('currentUser.preferences.selected_measure_ids.[]')
    @get('model.measures').filter (measure) -> measureIds.contains measure.get('hqmfId')
  ).property('currentUser.preferences.selected_measure_ids.[]', 'model.measures')

PopHealth.SidebarCategoryController = PopHealth.DashboardCategoryController.extend
  isOpen: no # by default; view listens for open/close event and sets this accordingly
  isSelected: ( ->
    @get('selectedMeasures.length') > 0
  ).property('selectedMeasures.length')

  isAllSelected: ( ->
    @get('selectedMeasures.length') == @get('model.measures.length')
  ).property('selectedMeasures.length', 'model.measures.length')

  measureCount: ( ->
    @get 'selectedMeasures.length'
  ).property('selectedMeasures.length')

  actions:
    selectAll: ->
      selectedIds = @get 'currentUser.preferences.selected_measure_ids.[]'
      measureIds = @get('model.measures').mapBy 'hqmfId'
      if @get('isAllSelected')
        selectedIds = selectedIds.reject (id) -> measureIds.contains id
      else
        measureIds.forEach (id) -> selectedIds.push(id) unless selectedIds.contains id
      @set('currentUser.preferences.selected_measure_ids.[]', selectedIds)


PopHealth.DashboardMeasureController = Ember.ObjectController.extend
  isSelected: ( ->
    measureIds = @get('currentUser.preferences.selected_measure_ids.[]')
    measureIds.contains @get('model.hqmfId')
  ).property('currentUser.preferences.selected_measure_ids.[]')

  actions:
    select: ->
      hqmfId = @get('model.hqmfId')
      measureIds = @get('currentUser.preferences.selected_measure_ids.[]')
      if measureIds.contains hqmfId
        idx = measureIds.indexOf hqmfId
        measureIds.splice idx, 1
      else
        measureIds.push hqmfId
      @set('currentUser.preferences.selected_measure_ids.[]', measureIds)

PopHealth.DashboardSubmeasureController = Ember.ObjectController.extend
  init: ->
    store = @get 'store'
    hqmfId = @parentController.get 'hqmfId'
    subId = @get 'subId'
  isPrimary: ( ->
    subId = @get('subId')
    !subId? or subId is 'a'
  ).property('model.subId')
