PopHealth.Query = DS.Model.extend
  hqmfId: DS.attr()
  subId: DS.attr()
  result: DS.attr()
  isPopulated: ( ->
    @get('result')?
  ).property('result')


# PopHealth.PollingQuery = Ember.Object.extend
#   interval: ( -> 3000 ).property().readOnly()

#   schedule: (f) ->
#     Ember.run.later this, ->
#       f.apply this
#       @set 'timer', @schedule f
#     , @get 'interval'

#   stop: -> Ember.run.cancel @get('timer')

#   start: -> @set 'timer', @schedule @get('onPoll')

#   onPoll: ->
#     store = @get 'store'
#     query = @get 'query'
#     unless query?
#       hqmfId = @get 'hqmfId'
#       subId = @get 'subId'
#       query = store.createRecord 'query',
#         hqmfId: hqmfId
#         subId: subId
#       # query.save()
#       @set 'query', query
#     else
#       if query.get('isPopulated') then @stop() else query.reload()


# These get 'created' on the server
PopHealth.Query.FIXTURES = for i in [0...100]
  id: "fixture-#{i}"
  # these should correspond to the measure that created them, but it doesn't matter too much for testing purposes yet
  hqmfId: '40280381-3D61-56A7-013E-6224E2AC25F3'
  subId: null
  result: if Math.round(Math.random() * 100) > 40
    NUMER: Math.round(Math.random() * 5)
    DENEX: Math.round(Math.random() * 2)
    DENEXCEP: Math.round(Math.random() * 2)
    DENOM: Math.round(Math.random() * 3) + 6
    IPP: Math.round(Math.random() * 10) + 9
    MSRPOPL: 0
    OBSERV: 0
