/* global describe, it, beforeEach, expect */

(function () {
  'use strict';

  describe('Query model', function () {
    var query;
    beforeEach(function() {
      var store = PopHealth.__container__.lookup('store:main');
      Ember.run(function() {
        query = store.createRecord('query', {
          hqmfId: 'hqmf id',
          subId: 'a'
        });
        query = store.find('query', query.get('id'));
      });
    });
    it('is populated if the status is completed', function () {
      expect(query.get('isPopulated')).to.equal(false);
      Ember.run(function() {
        query.set('status', {state: 'completed'});
      });
      expect(query.get('isPopulated')).to.equal(true);
    });
  });
})();
