class Crowdblog.Models.Post extends Backbone.Model
  paramRoot: 'post'

  url: ->
    'posts/' + @id

