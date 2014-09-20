{Robot, User, TextMessage} = require 'hubot'
assert = require 'power-assert'
path = require 'path'
sinon = require 'sinon'

describe 'planet-of-the-apes', ->
  beforeEach (done) ->
    @sinon = sinon.sandbox.create()
    # for warning: possible EventEmitter memory leak detected.
    # process.on 'uncaughtException'
    @sinon.stub process, 'on', -> null
    @robot = new Robot(path.resolve(__dirname, '..'), 'shell', false, 'hubot')
    @robot.adapter.on 'connected', =>
      @robot.load path.resolve(__dirname, '../../src/scripts')
      setTimeout done, 10 # wait for parseHelp()
    @robot.run()

  afterEach (done) ->
    @robot.brain.on 'close', =>
      @sinon.restore()
      done()
    @robot.shutdown()

  describe 'listeners[0].regex', ->
    describe 'valid patterns', ->
      beforeEach ->
        @tests = [
          message: '@hubot where am i'
          matches: ['@hubot where am i']
        ,
          message: '@hubot where am I?'
          matches: ['@hubot where am I?']
        ]

      it 'should match', ->
        @tests.forEach ({ message, matches }) =>
          callback = @sinon.spy()
          @robot.listeners[0].callback = callback
          sender = new User 'bouzuya', room: 'hitoridokusho'
          @robot.adapter.receive new TextMessage(sender, message)
          actualMatches = callback.firstCall.args[0].match.map((i) -> i)
          assert callback.callCount is 1
          assert.deepEqual actualMatches, matches

  describe 'listeners[0].callback', ->
    beforeEach ->
      @hello = @robot.listeners[0].callback

    describe 'receive "@hubot where am i"', ->
      beforeEach ->
        @send = @sinon.spy()
        @hello
          match: ['@hubot where am i']
          send: @send

      it 'send "You are in the earth."', ->
        assert @send.callCount is 1
        assert @send.firstCall.args[0] is 'You are in the earth.'

  describe 'robot.helpCommands()', ->
    it 'should be ["hubot where am i - ???"]', ->
      assert.deepEqual @robot.helpCommands(), [
        "hubot where am i - ???"
      ]
