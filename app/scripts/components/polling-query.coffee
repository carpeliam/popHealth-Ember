PopHealth.PollingQueryComponent = Ember.Component.extend
  createQuery: ( ->
    hqmfId = @get 'hqmfId'
    subId = @get 'subId'

    query = @store.createRecord 'query',
      hqmfId: hqmfId
      subId: subId
    # # query.save() # FixtureAdapter isn't smart enough for this, remove for RESTAdapter
    @set 'model', query

    @poll()
  ).on('init')

  interval: ( -> 3000 ).property().readOnly()

  performanceRate: Em.computed.oneWay 'model.performanceRate'
  numerator: Em.computed.oneWay 'model.numerator'
  performanceDenominator: Em.computed.oneWay 'model.performanceDenominator'
  isPopulated: ( -> @sendAction() if @get('model.isPopulated')).observes('model.isPopulated')

  stop: -> Em.run.cancel @get('queryTimer')
  willDestroy: -> @stop()
  poll: ->
    query = @get 'model'
    if query.get('isPopulated')
      @stop()
    else
      query.reload()
      @set 'queryTimer', Em.run.later this, @poll, @get('interval')
