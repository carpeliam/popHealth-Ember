# global Ember
PopHealth.Measure = DS.Model.extend
  cmsId: DS.attr()
  hqmfId: DS.attr()
  name: DS.attr()
  description: DS.attr()
  continuousVariable: DS.attr()
  episodeOfCare: DS.attr()
  category: DS.belongsTo 'category'#, async: yes
  subs: DS.attr()
  submeasures: DS.hasMany 'submeasure'
  cmsNumber: ( ->
    matches = @get('cmsId').match(/CMS(\d+)v(\d+)/)
    matches?[1]
  ).property 'cmsId'
  cmsVersion: ( ->
    matches = @get('cmsId').match(/CMS(\d+)v(\d+)/)
    matches?[2]
  ).property 'cmsId'

# probably should be mixed-in...
# PopHealth.Measure.reopen
#   attributes: ( ->
#     Ember.keys(@get('data')).map (key) =>
#       Em.Object.create model: this, key: key, valueBinding: "model.#{key}"
#   ).property()


# delete below here if you do not want fixtures
PopHealth.Measure.FIXTURES = [
  id: 1
  cmsId: 'CMS117v2'
  hqmfId: '40280381-3D61-56A7-013E-6224E2AC25F3'
  name: 'Childhood Immunization Status'
  description: 'Percentage of children 2 years of age who had four diphtheria, tetanus and acellular pertussis (DTaP); three polio (IPV), one measles, mumps and rubella (MMR); three H influenza type B (HiB); three hepatitis B (Hep B); one chicken pox (VZV); four pneumococcal conjugate (PCV); one hepatitis A (Hep A); two or three rotavirus (RV); and two influenza (flu) vaccines by their second birthday.'
  continuousVariable: no
  episodeOfCare: no
  category: 1
  submeasures: []
,
  id: 2
  cmsId: 'CMS136v3'
  hqmfId: '40280381-3D61-56A7-013E-62E052273699'
  name: 'ADHD: Follow-Up Care for Children Prescribed Attention-Deficit/Hyperactivity Disorder (ADHD) Medication'
  description: 'Percentage of children 6-12 years of age and newly dispensed a medication for attention-deficit/hyperactivity disorder (ADHD) who had appropriate follow-up care.  Two rates are reported.  \na. Percentage of children who had one follow-up visit with a practitioner with prescribing authority during the 30-Day Initiation Phase.\nb. Percentage of children who remained on ADHD medication for at least 210 days and who, in addition to the visit in the Initiation Phase, had at least two additional follow-up visits with a practitioner within 270 days (9 months) after the Initiation Phase ended.'
  continuousVariable: no
  episodeOfCare: no
  category: 1
  submeasures: [1, 2]
,
  id: 3
  cmsId: 'CMS100v2'
  hqmfId: '40280381-3D27-5493-013D-4BFBD29A5F66'
  name: 'Aspirin Prescribed at Discharge'
  description: 'Acute myocardial infarction (AMI) patients who are prescribed aspirin at hospital discharge'
  continuousVariable: no
  episodeOfCare: yes
  category: 2
  submeasures: []
]
