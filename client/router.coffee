Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'

MethodSearch = new Mongo.Collection(null)

Router.map ->
  @route('index'
    path: '/'
    template: 'index'
  )
  @route('currentState'
    path: '/currentstate'
    template: 'testTime'
    data: ->
      data =
        subs: @subs
        getTestData1: ->
          if @subs and @subs.testData1.ready()
            Test2.find()
        getTestData2: ->
          if @subs and @subs.testData2.ready()
            Test3.find()
        getTestData3: ->
          if @subs and @subs.testData3.ready()
            Test4.find()
        getMockData: ->
          if @subs and @subs.mockData.ready()
            Test1.find()
        ready: ->
          return @subs and @subs.mockData.ready()
    subscriptions: ->
      @subs =
        testData1: Meteor.subscribe("publishWithBlock1")
        testData2: Meteor.subscribe("publishWithBlock2")
        testData3: Meteor.subscribe("publishWithBlock3")
        mockData: Meteor.subscribe('mockData')
      null
  )
  @route('subswithunblock'
    path: '/subswithunblock'
    template: 'testTime'
    data: ->
      data =
        subs: @subs
        getTestData1: ->
          if @subs and @subs.testData1.ready()
            Test2.find()
        getTestData2: ->
          if @subs and @subs.testData2.ready()
            Test3.find()
        getTestData3: ->
          if @subs and @subs.testData3.ready()
            Test4.find()
        getMockData: ->
          if @subs and @subs.mockData.ready()
            Test1.find()
        ready: ->
          return @subs and @subs.mockData.ready()
    subscriptions: ->
      @subs =
        testData1: Meteor.subscribe("publishWithUnblock1")
        testData2: Meteor.subscribe("publishWithUnblock2")
        testData3: Meteor.subscribe("publishWithUnblock3")
        mockData: Meteor.subscribe('mockData')
      null
  )

  @route('subswithunblockwithouthistory'
    path: '/subswithunblockwithouthistory'
    template: 'testTime'
    data: ->
      data =
        subs: @subs
        getTestData1: ->
          if @subs and @subs.testData1.ready()
            Test2.find()
        getTestData2: ->
          if @subs and @subs.testData2.ready()
            Test3.find()
        getTestData3: ->
          if @subs and @subs.testData3.ready()
            Test4.find()
        getMockData: ->
          if @subs and @subs.mockData.ready()
            Test1.find()
        ready: ->
          return @subs and @subs.mockData.ready()
    subscriptions: ->
      @subs =
        testData1: Meteor.subscribe("publishWithUnblock1")
        testData2: Meteor.subscribe("publishWithUnblock2")
        testData3: Meteor.subscribe("publishWithUnblock3")
        mockData: Meteor.subscribe('mockDataWithoutHistory')
      null
  )

  @route('method'
    path: '/method'
    template: 'testTime'
    onRun: ->
      MethodSearch.remove({})
      Meteor.call('mockData', (err, res)->
        _.each(res, (data) ->
          MethodSearch.insert(data)
        )
      )
      @next()
    data: ->
      data =
        subs: @subs
        getTestData1: ->
          if @subs and @subs.testData1.ready()
            Test2.find()
        getTestData2: ->
          if @subs and @subs.testData2.ready()
            Test3.find()
        getTestData3: ->
          if @subs and @subs.testData3.ready()
            Test4.find()
        getMockData: -> MethodSearch.find()
        ready: -> MethodSearch.find().count()
    subscriptions: ->
      @subs =
        testData1: Meteor.subscribe("publishWithUnblock1")
        testData2: Meteor.subscribe("publishWithUnblock2")
        testData3: Meteor.subscribe("publishWithUnblock3")
      null
  )

  @route('unblockedmethod'
    path: '/unblockedmethod'
    template: 'testTime'
    onRun: ->
      MethodSearch.remove({})
      Meteor.call('unblockedMockData', (err, res)->
        _.each(res, (data) ->
          MethodSearch.insert(data)
        )
      )
      @next()
    data: ->
      data =
        subs: @subs
        getTestData1: ->
          if @subs and @subs.testData1.ready()
            Test2.find()
        getTestData2: ->
          if @subs and @subs.testData2.ready()
            Test3.find()
        getTestData3: ->
          if @subs and @subs.testData3.ready()
            Test4.find()
        getMockData: -> MethodSearch.find()
        ready: -> MethodSearch.find().count()
    subscriptions: ->
      @subs =
        testData1: Meteor.subscribe("publishWithUnblock1")
        testData2: Meteor.subscribe("publishWithUnblock2")
        testData3: Meteor.subscribe("publishWithUnblock3")
      null
  )

  @route('methodwithouthistory'
    path: '/methodwithouthistory'
    template: 'testTime'
    onRun: ->
      MethodSearch.remove({})
      Meteor.call('mockDataWithoutHistory', (err, res)->
        _.each(res, (data) ->
          MethodSearch.insert(data)
        )
      )
      @next()
    data: ->
      data =
        subs: @subs
        getTestData1: ->
          if @subs and @subs.testData1.ready()
            Test2.find()
        getTestData2: ->
          if @subs and @subs.testData2.ready()
            Test3.find()
        getTestData3: ->
          if @subs and @subs.testData3.ready()
            Test4.find()
        getMockData: -> MethodSearch.find()
        ready: -> MethodSearch.find().count()
    subscriptions: ->
      @subs =
        testData1: Meteor.subscribe("publishWithUnblock1")
        testData2: Meteor.subscribe("publishWithUnblock2")
        testData3: Meteor.subscribe("publishWithUnblock3")
      null
  )


  MockData = new Mongo.Collection(null)

  @route('pseudosub'
    path: '/pseudosub'
    template: 'testTime'
    data: ->
      data =
        subs: @subs
        getTestData1: ->
          if @subs and @subs.testData1.ready()
            Test2.find()
        getTestData2: ->
          if @subs and @subs.testData2.ready()
            Test3.find()
        getTestData3: ->
          if @subs and @subs.testData3.ready()
            Test4.find()
        getMockData: -> MockData.find()
        ready: -> @subs and @subs.mockData.ready()
    subscriptions: ->
      @subs =
        mockData: PseudoSub.subscribe(MockData, "mockData")
        testData1: Meteor.subscribe("publishWithUnblock1")
        testData2: Meteor.subscribe("publishWithUnblock2")
        testData3: Meteor.subscribe("publishWithUnblock3")
      null
  )



#  @route 'foos_show',
#    path: '/foo/:_id',
#    template: 'foos_show'
#    waitOn: ->
#      return Meteor.subscribe('foos')
#    data: ->
#      return Foos.findOne({_id: @params._id})
