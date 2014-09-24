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




PopHealth.Pollable = Ember.Mixin.create
  init: ->
    @_super()
    hqmfId = @get('hqmfId') or @parentController.get('hqmfId')
    subId = @get 'subId'

    query = @get('store').createRecord 'query',
      hqmfId: hqmfId
      subId: subId
    # query.save() # FixtureAdapter isn't smart enough for this, remove for RESTAdapter
    @set 'query', query
    
    @set 'timer', @schedule @get('onPoll')

  interval: ( -> 3000 ).property().readOnly()

  schedule: (f) ->
    Ember.run.later this, ->
      f.apply this
      @set 'timer', @schedule f
    , @get 'interval'

  stop: -> Ember.run.cancel @get('timer')
  # start: -> @set 'timer', @schedule @get('onPoll')
  onPoll: ->
    query = @get 'query'
    if query.get('isPopulated') then @stop() else query.reload()

  numerator: ( ->
    if @get('query.isPopulated') then @get('query.result.NUMER') else 0
  ).property('query.isPopulated', 'query.result.NUMER')
  denominator: ( ->
    if @get('query.isPopulated') then @get('query.result.DENOM') else 0
  ).property('query.isPopulated', 'query.result.DENOM')
  exceptions: ( ->
    if @get('query.isPopulated') then @get('query.result.DENEXCEP') else 0
  ).property('query.isPopulated', 'query.result.DENEXCEP')
  exclusions: ( ->
    if @get('query.isPopulated') then @get('query.result.DENEX') else 0
  ).property('query.isPopulated', 'query.result.DENEX')
  performanceDenominator: ( ->
    @get('denominator') - @get('exceptions') - @get('exclusions')
  ).property('denominator', 'exceptions', 'exclusions')
  performanceRate: ( ->
    Math.round(100 * @get('numerator') / Math.max(1, @get('performanceDenominator')))
  ).property('numerator', 'performanceDenominator')



PopHealth.DashboardMeasureResultController = Ember.ObjectController.extend PopHealth.Pollable

PopHealth.DashboardSubmeasureController = Ember.ObjectController.extend PopHealth.Pollable,
  isPrimary: ( ->
    subId = @get('subId')
    !subId? or subId is 'a'
  ).property('model.subId')
