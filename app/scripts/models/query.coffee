PopHealth.Query = DS.Model.extend
  hqmfId: DS.attr()
  subId: DS.attr()
  results: DS.attr()
  isPopulated: ( ->
    @get('results')?
  ).property('results')


PopHealth.PollingQuery = Ember.Object.extend
  interval: ( -> 3000 ).property().readOnly()

  schedule: (f) ->
    Ember.run.later this, ->
      f.apply this
      @set 'timer', @schedule f
    , @get 'interval'

  stop: -> Ember.run.cancel @get('timer')

  start: -> @set 'timer', @schedule @get('onPoll')

  onPoll: ->
    store = @get 'store'
    query = @get 'query'
    unless query?
      hqmfId = @get 'hqmfId'
      subId = @get 'subId'
      query = store.createRecord 'query',
        hqmfId: hqmfId
        subId: subId
      # query.save()
      @set 'query', query
    else
      if query.get('isPopulated') then @stop() else query.reload()


# These get 'created' on the server
PopHealth.Query.FIXTURES = [
  id: 'fixture-0'
  hqmfId: '40280381-3D61-56A7-013E-6224E2AC25F3'
  subId: null
,
  id: 'fixture-1'
  hqmfId: '40280381-3D61-56A7-013E-62E052273699'
  subId: 'a'
  results:
    NUMER: 3
,
  id: 'fixture-2'
  hqmfId: '40280381-3D61-56A7-013E-62E052273699'
  subId: 'a'
  results:
    NUMER: 5
]
