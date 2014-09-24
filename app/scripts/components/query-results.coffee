PopHealth.QueryResultsComponent = Ember.Component.extend
  init: ->
    @_super()
    store = @get 'targetObject.store'
    hqmfId = @get 'hqmfId'
    subId = @get 'subId'
    q = PopHealth.PollingQuery.create store: store, hqmfId: hqmfId, subId: subId
    q.start()
    @set 'model', q.get('query')
  numerator: ( ->
    if @get('model.isPopulated') then @get('model.results.NUMER') else '--'
  ).property('model.isPopulated')
