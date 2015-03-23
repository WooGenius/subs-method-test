Meteor.publish('publishWithBlock1', ->
  Meteor._sleepForMs(1000 * 1)
  Test2.find()
)

Meteor.publish('publishWithBlock2', ->
  Meteor._sleepForMs(1000 * 1)
  Test3.find()
)

Meteor.publish('publishWithBlock3', ->
  Meteor._sleepForMs(1000 * 1)
  Test4.find()
)

Meteor.publish('mockData', ->
  Test1.find()
)

Meteor.publish('mockDataWithoutHistory', ->
  Test1.find({},
    fields:
      description: 0
      detailed_description: 0
  )
)

Meteor.publish('publishWithUnblock1', ->
  @unblock()
  Meteor._sleepForMs(1000 * 1)
  Test2.find()
)

Meteor.publish('publishWithUnblock2', ->
  @unblock()
  Meteor._sleepForMs(1000 * 1)
  Test3.find()
)

Meteor.publish('publishWithUnblock3', ->
  @unblock()
  Meteor._sleepForMs(1000 * 1)
  Test4.find()
)

Meteor.methods(
  'unblockedMockData': ->
    @unblock()
    Test1.find().fetch()
  'mockData': ->
    Test1.find().fetch()
  'mockDataWithoutHistory': ->
    @unblock()
    Test1.find({},
      fields:
        description: 0
        detailed_description: 0
    ).fetch()
)
