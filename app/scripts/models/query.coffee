PopHealth.Query = DS.Model.extend
  hqmfId: DS.attr()
  subId: DS.attr()
  status: DS.attr()
  result: DS.attr()
  isPopulated: ( ->
    @get('status.state') in ['completed']
  ).property('status.state')
  # numerator: Em.computed.defaultTo('result.NUMER'), 0 # is this good enough?
  numerator: ( ->
    if @get('isPopulated') then @get('result.NUMER') else 0
  ).property('isPopulated', 'result.NUMER')
  denominator: ( ->
    if @get('isPopulated') then @get('result.DENOM') else 0
  ).property('isPopulated', 'result.DENOM')
  exceptions: ( ->
    if @get('isPopulated') then @get('result.DENEXCEP') else 0
  ).property('isPopulated', 'result.DENEXCEP')
  exclusions: ( ->
    if @get('isPopulated') then @get('result.DENEX') else 0
  ).property('isPopulated', 'result.DENEX')
  performanceDenominator: ( ->
    @get('denominator') - @get('exceptions') - @get('exclusions')
  ).property('denominator', 'exceptions', 'exclusions')
  performanceRate: ( ->
    Math.round(100 * @get('numerator') / Math.max(1, @get('performanceDenominator')))
  ).property('numerator', 'performanceDenominator')


# These get 'created' on the server
PopHealth.Query.FIXTURES = for i in [0...100]
  hasResult = Math.round(Math.random() * 100) > 40
  id: "fixture-#{i}"
  # these should correspond to the measure that created them, but it doesn't matter too much for testing purposes yet
  hqmfId: '40280381-3D61-56A7-013E-6224E2AC25F3'
  subId: null
  status:
    state: if hasResult then 'completed' else 'pending'
  result: if hasResult
    NUMER: Math.round(Math.random() * 5)
    DENEX: Math.round(Math.random() * 2)
    DENEXCEP: Math.round(Math.random() * 2)
    DENOM: Math.round(Math.random() * 3) + 6
    IPP: Math.round(Math.random() * 10) + 9
    MSRPOPL: 0
    OBSERV: 0
