
Montage = require("montage").Montage
Reqwest = require("reqwest")

RangeController = require("montage/core/range-controller").RangeController

exports.DiscourseController = Montage.specialize
  siteAddress: value: null
  
  category: value: null
  
  topic: value: null

  constructor:
    value: ->
      @categories = {}
      @topics = {}
      @posts = {}

      @categoryController = new RangeController()
      @topicController = new RangeController()
      @postController = new RangeController()

      @defineBinding "categoryController.content", "<-": "categories.category_list.categories"
      @defineBinding "topicController.content", "<-": "topics.topic_list.topics"
      @defineBinding "postController.content", "<-": "posts.post_stream.posts"

      @defineBinding "category", "<-": "category ?? categoryController.selection.0.slug"
      @defineBinding "topic", "<-": "topic ?? topicController.selection.0.id"

      @addOwnPropertyChangeListener "category", this
      @addOwnPropertyChangeListener "topic", this

  initializeForum:
    value: ->
      @getCategories().then (output) =>
        @categories = output

  handleCategoryChange:
    value: (selected) ->
      return if selected == null
      @getTopics().then (output) =>
        @topics = output

  handleTopicChange:
    value: (selected) ->
      return if selected == null
      @getPosts().then (output) =>
        @posts = output

  getRequest:
    value: (path, params) ->
      url = "http://#{@siteAddress}/#{path}.json"
      url += "?" + Reqwest.toQueryString params if params
      Reqwest url: url, type: "json", method: "get", crossOrigin: true

  getCategories:
    value: ->
      @getRequest "categories"

  getTopics:
    value: (category) ->
      cat = category || @category
      @getRequest if cat == "" then "latest" else "category/#{cat}"

  getPosts:
    value: (topicId) ->
      @getRequest "t/#{topicId || @topic}"
