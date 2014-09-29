(function(){var a;a=window.PopHealth=Ember.Application.create({customEvents:{"show.bs.collapse":"showCollapse","hidden.bs.collapse":"hideCollapse"}}),function(){Ember.Handlebars.helper("formatNumeral",function(a,b){return numeral(a).format(b)})}.call(this),function(){a.IndexController=Ember.ArrayController.extend({selectedCategories:function(){return Ember.ArrayProxy.createWithMixins(Ember.SortableMixin,{sortProperties:["name"],sortFunction:function(a,b){return"Core"===a?-1:"Core"===b?1:Em.compare(a,b)},content:[]})}.property(),updateSelectedCategories:function(){var a,b;return a=this.get("currentUser.preferences.selected_measure_ids.[]"),b=this.get("selectedCategories"),this.forEach(function(c){return c.get("measures").any(function(b){return a.contains(b.get("hqmfId"))})?b.contains(c)?void 0:b.addObject(c):b.removeObject(c)})}.observes("currentUser.preferences.selected_measure_ids.[]","model.length","@each.measures.length").on("init")}),a.DashboardCategoryController=Ember.ObjectController.extend({selectedMeasures:function(){return Ember.ArrayProxy.createWithMixins(Ember.SortableMixin,{sortProperties:["cmsId"],content:[]})}.property(),updateSelectedMeasures:function(){var a,b;return a=this.get("currentUser.preferences.selected_measure_ids.[]"),b=this.get("selectedMeasures"),this.get("measures").forEach(function(c){return a.contains(c.get("hqmfId"))?b.contains(c)?void 0:b.addObject(c):b.removeObject(c)})}.observes("currentUser.preferences.selected_measure_ids.[]","measures.length").on("init")}),a.SidebarCategoryController=a.DashboardCategoryController.extend({isOpen:!1,isSelected:Em.computed.gt("selectedMeasures.length",0),isAllSelected:function(){return this.get("selectedMeasures.length")===this.get("measures.length")}.property("selectedMeasures.length","measures.length"),measureCount:Em.computed.oneWay("selectedMeasures.length"),actions:{selectAll:function(){var a,b;return b=this.get("currentUser.preferences.selected_measure_ids.[]"),a=this.get("measures").mapBy("hqmfId"),this.get("isAllSelected")?b=b.reject(function(b){return a.contains(b)}):a.forEach(function(a){return b.contains(a)?void 0:b.push(a)}),this.set("currentUser.preferences.selected_measure_ids.[]",b)}}}),a.DashboardMeasureController=Ember.ObjectController.extend({isSelected:function(){var a;return a=this.get("currentUser.preferences.selected_measure_ids.[]"),a.contains(this.get("hqmfId"))}.property("currentUser.preferences.selected_measure_ids.[]"),actions:{select:function(){var a,b;return a=this.get("hqmfId"),b=this.get("currentUser.preferences.selected_measure_ids.[]"),b.contains(a)?b.removeObject(a):b.addObject(a),this.set("currentUser.preferences.selected_measure_ids.[]",b)}}}),a.DashboardMeasureResultController=Ember.ObjectController.extend({actions:{setPopulated:function(){return this.set("isPopulated",!0)}}}),a.DashboardSubmeasureController=Ember.ObjectController.extend({isPrimary:function(){var a;return a=this.get("subId"),null==a||"a"===a}.property("subId"),actions:{setPopulated:function(){return this.set("isPopulated",!0)}}})}.call(this),function(){a.ApplicationAdapter=DS.FixtureAdapter}.call(this),function(){a.Category=DS.Model.extend({name:DS.attr(),measures:DS.hasMany("measure")}),a.Category.FIXTURES=[{id:1,name:"Core",measures:[1,2]},{id:2,name:"Acute Myocardial Infarction",measures:[3]}]}.call(this),function(){a.Measure=DS.Model.extend({cmsId:DS.attr(),hqmfId:DS.attr(),name:DS.attr(),description:DS.attr(),continuousVariable:DS.attr(),episodeOfCare:DS.attr(),category:DS.belongsTo("category"),subs:DS.attr(),cmsNumber:function(){var a;return a=this.get("cmsId").match(/CMS(\d+)v(\d+)/),null!=a?a[1]:void 0}.property("cmsId"),cmsVersion:function(){var a;return a=this.get("cmsId").match(/CMS(\d+)v(\d+)/),null!=a?a[2]:void 0}.property("cmsId")}),a.Measure.FIXTURES=[{id:1,cmsId:"CMS117v2",hqmfId:"40280381-3D61-56A7-013E-6224E2AC25F3",name:"Childhood Immunization Status",description:"Percentage of children 2 years of age who had four diphtheria, tetanus and acellular pertussis (DTaP); three polio (IPV), one measles, mumps and rubella (MMR); three H influenza type B (HiB); three hepatitis B (Hep B); one chicken pox (VZV); four pneumococcal conjugate (PCV); one hepatitis A (Hep A); two or three rotavirus (RV); and two influenza (flu) vaccines by their second birthday.",continuousVariable:!1,episodeOfCare:!1,category:1,submeasures:[]},{id:2,cmsId:"CMS136v3",hqmfId:"40280381-3D61-56A7-013E-62E052273699",name:"ADHD: Follow-Up Care for Children Prescribed Attention-Deficit/Hyperactivity Disorder (ADHD) Medication",description:"Percentage of children 6-12 years of age and newly dispensed a medication for attention-deficit/hyperactivity disorder (ADHD) who had appropriate follow-up care.  Two rates are reported.  \na. Percentage of children who had one follow-up visit with a practitioner with prescribing authority during the 30-Day Initiation Phase.\nb. Percentage of children who remained on ADHD medication for at least 210 days and who, in addition to the visit in the Initiation Phase, had at least two additional follow-up visits with a practitioner within 270 days (9 months) after the Initiation Phase ended.",continuousVariable:!1,episodeOfCare:!1,category:1,submeasures:[1,2]},{id:3,cmsId:"CMS100v2",hqmfId:"40280381-3D27-5493-013D-4BFBD29A5F66",name:"Aspirin Prescribed at Discharge",description:"Acute myocardial infarction (AMI) patients who are prescribed aspirin at hospital discharge",continuousVariable:!1,episodeOfCare:!0,category:2,submeasures:[]}]}.call(this),function(){var b,c;a.Query=DS.Model.extend({hqmfId:DS.attr(),subId:DS.attr(),status:DS.attr(),result:DS.attr(),isPopulated:function(){var a;return"completed"===(a=this.get("status.state"))}.property("status.state"),numerator:function(){return this.get("isPopulated")?this.get("result.NUMER"):0}.property("isPopulated","result.NUMER"),denominator:function(){return this.get("isPopulated")?this.get("result.DENOM"):0}.property("isPopulated","result.DENOM"),exceptions:function(){return this.get("isPopulated")?this.get("result.DENEXCEP"):0}.property("isPopulated","result.DENEXCEP"),exclusions:function(){return this.get("isPopulated")?this.get("result.DENEX"):0}.property("isPopulated","result.DENEX"),performanceDenominator:function(){return this.get("denominator")-this.get("exceptions")-this.get("exclusions")}.property("denominator","exceptions","exclusions"),performanceRate:function(){return Math.round(100*this.get("numerator")/Math.max(1,this.get("performanceDenominator")))}.property("numerator","performanceDenominator")}),a.Query.FIXTURES=function(){var a,d;for(d=[],c=a=0;100>a;c=++a)b=Math.round(100*Math.random())>40,d.push({id:"fixture-"+c,hqmfId:"40280381-3D61-56A7-013E-6224E2AC25F3",subId:null,status:{state:b?"completed":"pending"},result:b?{NUMER:Math.round(5*Math.random()),DENEX:Math.round(2*Math.random()),DENEXCEP:Math.round(2*Math.random()),DENOM:Math.round(3*Math.random())+6,IPP:Math.round(10*Math.random())+9,MSRPOPL:0,OBSERV:0}:void 0});return d}()}.call(this),function(){a.User=DS.Model.extend({username:DS.attr(),email:DS.attr(),preferences:DS.attr()})}.call(this),function(){a.IndexRoute=Ember.Route.extend({setupController:function(a){return a.set("model",this.get("store").all("category"))}})}.call(this),function(){a.PollingQueryComponent=Ember.Component.extend({createQuery:function(){var a,b,c;return a=this.get("hqmfId"),c=this.get("subId"),b=this.store.createRecord("query",{hqmfId:a,subId:c}),this.set("model",b),this.poll()}.on("init"),interval:function(){return 3e3}.property().readOnly(),performanceRate:Em.computed.oneWay("model.performanceRate"),numerator:Em.computed.oneWay("model.numerator"),performanceDenominator:Em.computed.oneWay("model.performanceDenominator"),isPopulated:function(){return this.get("model.isPopulated")?this.sendAction():void 0}.observes("model.isPopulated"),stop:function(){return Em.run.cancel(this.get("queryTimer"))},willDestroy:function(){return this.stop()},poll:function(){var a;return a=this.get("model"),a.get("isPopulated")?this.stop():(a.reload(),this.set("queryTimer",Em.run.later(this,this.poll,this.get("interval"))))}})}.call(this),function(){a.SidebarCategoryView=Ember.View.extend({classNames:["panel","panel-default"],showCollapse:function(){var a;return a=this.get("controller"),a.set("isOpen",!0)},hideCollapse:function(){var a;return a=this.get("controller"),a.set("isOpen",!1)}})}.call(this),function(){a.Router.map(function(){return this.resource("measure",{path:"measures/:hqmf_id"},function(){return this.resource("submeasure",{path:"/:sub_id"},function(){return this.resource("patientResults",{path:"/patient_results"})})})})}.call(this)}).call(this);