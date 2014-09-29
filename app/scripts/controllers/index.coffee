PopHealth.IndexController = Ember.ArrayController.extend
  selectedCategories: ( ->
    Ember.ArrayProxy.createWithMixins Ember.SortableMixin,
      sortProperties: ['name']
      sortFunction: (a, b) ->
        if a is 'Core'
          -1
        else if b is 'Core'
          1
        else
          Em.compare a, b
      content: [] # set in updateSelectedMeasures
  ).property()
  updateSelectedCategories: ( ->
    measureIds = @get 'currentUser.preferences.selected_measure_ids.[]'
    selectedCategories = @get 'selectedCategories'
    @forEach (category) ->
      if category.get('measures').any((measure) -> measureIds.contains measure.get('hqmfId'))
        selectedCategories.addObject(category) unless selectedCategories.contains category
      else
        selectedCategories.removeObject(category)
  ).observes('currentUser.preferences.selected_measure_ids.[]', 'model.length', '@each.measures.length').on('init')


PopHealth.DashboardCategoryController = Ember.ObjectController.extend
  selectedMeasures: ( ->
    Ember.ArrayProxy.createWithMixins Ember.SortableMixin,
      sortProperties: ['cmsId']
      content: [] # set in updateSelectedMeasures
  ).property()
  updateSelectedMeasures: ( ->
    measureIds = @get('currentUser.preferences.selected_measure_ids.[]')
    selectedMeasures = @get 'selectedMeasures'
    @get('measures').forEach (measure) ->
      if measureIds.contains measure.get('hqmfId')
        selectedMeasures.addObject(measure) unless selectedMeasures.contains measure
      else
        selectedMeasures.removeObject(measure)
  ).observes('currentUser.preferences.selected_measure_ids.[]', 'measures.length').on('init')

PopHealth.SidebarCategoryController = PopHealth.DashboardCategoryController.extend
  isOpen: no # by default; view listens for open/close event and sets this accordingly
  isSelected: Em.computed.gt 'selectedMeasures.length', 0
  isAllSelected: ( ->
    @get('selectedMeasures.length') == @get('measures.length')
  ).property('selectedMeasures.length', 'measures.length')

  measureCount: Em.computed.oneWay('selectedMeasures.length')

  actions:
    selectAll: ->
      selectedIds = @get 'currentUser.preferences.selected_measure_ids.[]'
      measureIds = @get('measures').mapBy 'hqmfId'
      if @get('isAllSelected')
        selectedIds = selectedIds.reject (id) -> measureIds.contains id
      else
        measureIds.forEach (id) -> selectedIds.push(id) unless selectedIds.contains id
      @set('currentUser.preferences.selected_measure_ids.[]', selectedIds)


PopHealth.DashboardMeasureController = Ember.ObjectController.extend
  isSelected: ( ->
    measureIds = @get('currentUser.preferences.selected_measure_ids.[]')
    measureIds.contains @get('hqmfId')
  ).property('currentUser.preferences.selected_measure_ids.[]')

  actions:
    select: ->
      hqmfId = @get('hqmfId')
      measureIds = @get('currentUser.preferences.selected_measure_ids.[]')
      if measureIds.contains hqmfId
        measureIds.removeObject hqmfId
      else
        measureIds.addObject hqmfId
      @set('currentUser.preferences.selected_measure_ids.[]', measureIds)




PopHealth.Pollable = Ember.Mixin.create
  createQuery: ( ->
    hqmfId = @get('hqmfId') or @parentController.get('hqmfId')
    subId = @get 'subId'

    query = @get('store').createRecord 'query',
      hqmfId: hqmfId
      subId: subId
    # query.save() # FixtureAdapter isn't smart enough for this, remove for RESTAdapter
    @set 'query', query

    @poll()
  ).on('init')

  interval: ( -> 3000 ).property().readOnly()

  stop: -> Em.run.cancel @get('queryTimer')
  willDestroy: -> @stop()
  # start: -> @set 'timer', @schedule @get('onPoll')
  poll: ->
    query = @get 'query'
    if query.get('isPopulated')
      @stop()
    else
      query.reload()
      @set 'queryTimer', Em.run.later this, @poll, @get('interval')

  isPopulated: Em.computed.oneWay('query.isPopulated')
  # numerator: Em.computed.defaultTo('query.result.NUMER'), 0 # is this good enough?
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
  ).property('subId')
