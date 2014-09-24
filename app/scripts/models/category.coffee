PopHealth.Category = DS.Model.extend
  name: DS.attr()
  measures: DS.hasMany 'measure'#, async: yes


PopHealth.Category.FIXTURES = [
  id: 1
  name: 'Core'
  measures: [1, 2]
,
  id: 2
  name: 'Acute Myocardial Infarction'
  measures: [3]
]
