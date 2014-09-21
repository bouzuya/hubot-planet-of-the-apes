// Description
//   A Hubot script that DESCRIPTION
//
// Configuration:
//   None
//
// Commands:
//   hubot where am i - ???
//
// Author:
//   bouzuya <m@bouzuya.net>
//
module.exports = function(robot) {
  return robot.respond(/where am i\??$/i, function(res) {
    return res.send('You are on the earth.');
  });
};
