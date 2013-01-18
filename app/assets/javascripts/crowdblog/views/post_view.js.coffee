class Crowdblog.Views.PostView extends Backbone.View
  events:
    'click .publish': 'publish'
    'click .finish' : 'finish'
    'click .review' : 'review'
    'click .draft'  : 'draft'

  initialize: ->
    @model                  = new Crowdblog.Models.Post
    @model.id               = @postId()
    @publishIndicator       = @$el.find '.publish-status'
    @observePost()
    @model.trigger "post-#{@initialState()}"

  observePost: ->
    @model.on 'post-published', @markPublished, @
    @model.on 'post-finished',  @markFinished,  @
    @model.on 'post-reviewed',  @markReviewed,  @
    @model.on 'post-drafted',   @markDrafted,   @

  postId: ->
    @$el.data 'post-id'

  initialState: ->
    @$el.data 'state'

  publish: (e)->
    @model.publish()

  finish: (e)->
    @model.finish()

  review: (e)->
    @model.review()

  draft: (e) ->
    @model.draft()

  markPublished: ->
    publish_button = @$el.find '.publish-btn'
    review_button  = @$el.find '.states .review'
    publish_button.addClass    'btn-success'
    publish_button.removeClass 'btn-danger'
    publish_button.addClass    'draft'
    publish_button.removeClass 'publish'
    @setAsActive review_button
    @setPublishIndicator 'published'

  markFinished: ->
    button = @$el.find '.states .finish'
    @setAsActive button
    @setPublishIndicator 'not_published'

  markReviewed: ->
    button = @$el.find '.states .review'
    @setAsActive button
    @setPublishIndicator 'reviewed'

  markDrafted: ->
    publish_button = @$el.find '.publish-btn'
    button         = @$el.find '.states .draft'
    publish_button.addClass    'btn-danger'
    publish_button.removeClass 'btn-success'
    publish_button.addClass    'publish'
    publish_button.removeClass 'draft'
    @setAsActive button
    @setPublishIndicator 'not_published'

  setAsActive: (button)->
    last_active = @$el.find '.states button'
    last_active.removeClass 'active'
    last_active.removeClass 'btn-primary'
    button.addClass         'active btn-primary'

  setPublishIndicator: (status)->
    @publishIndicator.removeClass  'btn-warning btn-success btn-danger'
    switch status
      when 'reviewed'
        @publishIndicator.addClass 'btn-warning'
        @publishIndicator.html     'Reviewed'
      when 'published'
        @publishIndicator.addClass 'btn-success'
        @publishIndicator.html     'Published'
      else
        @publishIndicator.addClass 'btn-danger'
        @publishIndicator.html      'Not Published'

