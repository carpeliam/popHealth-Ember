PopHealth.QueryResultsView = Ember.View.extend
  templateName: 'components/query-results'
  init: ->
    @_super()
    store = @get 'controller.store'
    hqmfId = @get 'hqmfId'
    subId = @get 'subId'
    q = PopHealth.PollingQuery.create store: store, hqmfId: hqmfId, subId: subId
    q.start()
    @set 'query', q.get('query')
  numerator: ( ->
    console.log 'numer'
    if @get('query.isPopulated') then @get('query.results.NUMER') else '--'
  ).property('query.isPopulated')
