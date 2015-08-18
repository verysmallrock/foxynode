express = require 'express'
cookieParser = require 'cookie-parser'
path = require 'path'

app = express()

routes = require './server/routes'

app.set 'views', path.join(__dirname, 'client', 'views')
app.set 'view engine', 'jade'

app.use(express.static('build'));
app.use cookieParser()
app.use '/', routes

# These should be defined last (if something isn't handled, it is an error)
app.use (req, res, next) ->
  err = new Error('Not Found')
  err.status = 404
  next(err)

# development error handler
if app.get 'env' == 'development'
  app.use (err, req, res, next) ->
    res.status(err.status || 500)
    res.render('error', {
      message: err.message,
      error: err
    })

# production error handler
app.use (err, req, res, next) ->
  res.status(err.status || 500)
  res.render('error', {
    message: err.message,
    error: {}
  })

port = 3000
server = app.listen port, ->
  console.log "App listening at host, #{port}"
