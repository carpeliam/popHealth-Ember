PopHealth.Router.map ->
  @resource 'measure', path: 'measures/:hqmf_id', ->
    @resource 'submeasure', path: '/:sub_id', ->
      @resource 'patientResults', path: '/patient_results'
