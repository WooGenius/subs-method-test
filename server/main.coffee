Meteor.startup ->
  Test1.remove({})
  Test2.remove({})
  Test3.remove({})
  Test4.remove({})

  mockData = JSON.parse(Assets.getText("MOCK_DATA.json"))
  _.each(mockData, (data)->
    Test1.insert(data)
    Test2.insert(data)
    Test3.insert(data)
    Test4.insert(data)
  )

  console.log "Test Data #{Test1.find().count()} inserted"

  console.log "Test Data preparing done"

  # Bootstrap Collections
  # if not Foo.find().count()
  #   bootstrapFoo = [
  #     {
  #       name: 'Fooby'
  #     }
  #   ]

  #   _.each bootstrapFoo, (foo) ->
  #     Meteor.call 'addFoo', foo
