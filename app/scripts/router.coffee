PopHealth.Router.map ->
  # @resource 'measures', ->
  @resource 'measure', path: 'measures/:hqmf_id', ->
    @resource 'submeasure', path: '/:sub_id', ->
      @resource 'patientResults', path: '/patient_results'
    #   @resource 'submeasureProvider', path: 'providers/:provider_id'

    # @resource 'provider', path: 'providers/:provider_id'
