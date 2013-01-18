class Crowdblog.Models.Post extends Backbone.Model
  paramRoot: 'post'

  url: ->
    Crowdblog.adminPostsPath + '/' + @id

  publish: ->
    @performTransition 'publish', =>
      @trigger 'post-published'

  finish: ->
    @performTransition 'finish', =>
      @trigger 'post-finished'

  review: ->
    @performTransition 'review', =>
      @trigger 'post-reviewed'

  draft: ->
    @performTransition 'draft', =>
      @trigger 'post-drafted'

  performTransition: (transition, success)->
    $.ajax
      type: 'POST'
      url:  "/admin/posts/#{@id}/#{transition}"
      dataType: 'json'
      success: success
