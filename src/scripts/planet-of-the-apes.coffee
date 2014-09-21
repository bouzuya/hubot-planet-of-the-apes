# Description
#   A Hubot script that DESCRIPTION
#
# Configuration:
#   None
#
# Commands:
#   hubot where am i - ???
#
# Author:
#   bouzuya <m@bouzuya.net>
#
module.exports = (robot) ->
  robot.respond /where am i\??$/i, (res) ->
    res.send 'You are on the earth.'
