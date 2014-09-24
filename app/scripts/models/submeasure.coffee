PopHealth.Submeasure = DS.Model.extend
  subId: DS.attr()
  subTitle: DS.attr()
  description: DS.attr()
  measure: DS.belongsTo 'measure'
  isPrimary: ( ->
    @get('subId') is 'a'
  ).property 'subId'


PopHealth.Submeasure.FIXTURES = [
  id: 1
  subId: 'a'
  subTitle: 'Visit within 30 days'
  description: 'Percentage of children 6-12 years of age and newly dispensed a medication for attention-deficit/hyperactivity disorder (ADHD) who had appropriate follow-up care.  Two rates are reported.  \na. Percentage of children who had one follow-up visit with a practitioner with prescribing authority during the 30-Day Initiation Phase.\nb. Percentage of children who remained on ADHD medication for at least 210 days and who, in addition to the visit in the Initiation Phase, had at least two additional follow-up visits with a practitioner within 270 days (9 months) after the Initiation Phase ended.'
  measure: 2
,
  id: 2
  subId: 'b'
  subTitle: 'Visit with 2+ followups'
  description: 'Percentage of children 6-12 years of age and newly dispensed a medication for attention-deficit/hyperactivity disorder (ADHD) who had appropriate follow-up care.  Two rates are reported.  \na. Percentage of children who had one follow-up visit with a practitioner with prescribing authority during the 30-Day Initiation Phase.\nb. Percentage of children who remained on ADHD medication for at least 210 days and who, in addition to the visit in the Initiation Phase, had at least two additional follow-up visits with a practitioner within 270 days (9 months) after the Initiation Phase ended.'
  measure: 2
]
