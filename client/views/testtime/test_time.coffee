dataLoadingTime = new ReactiveVar()
dataSize = new ReactiveVar(0)

Template.testTime.created = ->
  @_startTime = new Date
  dataSize.set(0)

  Meteor.connection._stream.on('message', (data) ->
    dataSize.set(dataSize.get() + data.length)
  )

Template.testTime.rendered = ->
  self = this
  @autorun((comp)->
    if self.data.ready()
      now = new Date
      time = (now - self._startTime)/1000
      dataLoadingTime.set(time)
      console.log "Takes #{time}s"
      comp.stop()
  )

Template.testTime.helpers(
  toString: (data)-> JSON.stringify(data)
  dataLoadingTime: -> "#{dataLoadingTime.get()}s"
  dataSize: -> "#{dataSize.get()} bytes"
)
