class Crowdblog.Views.PostView extends Backbone.View
  events:
    'click a.publish' : 'publishPost'
    'click a.review' : 'markForReview'

  initialize: ->
    @model = new Crowdblog.Models.Post
      ready_for_review: (@$el.attr('data-ready-for-review') == 'true')

    @model.id = @postId()
    @model.bind('change:ready_for_review', @paintReviewButton)

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

  markForReview: (e) ->
    e.preventDefault()
    ready_for_review = @model.get('ready_for_review')
    if ready_for_review
      ready_for_review = false
    else
      ready_for_review = true

    @model.save 'ready_for_review', ready_for_review

  paintReviewButton: (post) =>
    if post.get('ready_for_review')
      @$el.find('a.review').addClass('btn-warning')
    else
      @$el.find('a.review').removeClass('btn-warning')
