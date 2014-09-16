PopHealth.Category = DS.Model.extend
  name: DS.attr()
  measures: DS.hasMany 'measure'#, async: yes

# probably should be mixed-in...
# PopHealth.Category.reopen
#   attributes: ( ->
#     Ember.keys(@get('data')).map (key) =>
#       Em.Object.create model: this, key: key, valueBinding: "model.#{key}"
#   ).property()


# delete below here if you do not want fixtures
PopHealth.Category.FIXTURES = [
  id: 1
  name: 'Core'
  measures: [1, 2]
,
  id: 2
  name: 'Acute Myocardial Infarction'
  measures: [3]
]
