class Crowdblog.Views.PostView extends Backbone.View
  events:
    'click a.publish' : 'publishPost'

  initialize: ->
    @model = new Crowdblog.Models.Post
    @model.id = @postId()

  publishPost: (e) ->
    e.preventDefault()
    if @postIsPublished()
      @model.save 'transition', 'draft', { success: @paintPostRow }
    else
      @model.save 'transition', 'publish', { success: @paintPostRow }


  postId: ->
    @$el.attr('data-post-id')

  paintPostRow: =>
    if @model.get('transition') == 'publish'
      @$el.find('a.publish').removeClass('btn-danger')
      @$el.find('a.publish').addClass('btn-success')
      @$el.attr('data-state', 'published')
    else
      @$el.find('a.publish').removeClass('btn-success')
      @$el.find('a.publish').addClass('btn-danger')
      @$el.attr('data-state', 'drafted')

    @$el.find('td.published-at').html(@model.get('published_at'))

  postIsPublished: ->
    @$el.attr('data-state') == 'published'
