
Montage = require("montage").Montage
Reqwest = require("reqwest")

RangeController = require("montage/core/range-controller").RangeController

exports.WordpressController = Montage.specialize
  siteAddress: value: null
  queryPosts: value: null

  constructor:
    value: ->
      @posts = []
      
      @addOwnPropertyChangeListener "queryPosts", this

  handleQueryPostsChange:
    value: (query) ->
      return if query == null
      @getPosts(query).then (output) =>
        console.log output
        @posts = output

  getPosts:
    value: (query) ->
      for key, val of query?.filter
        query["filter[#{key}]"] = val
      delete query?.filter
      @getRequest "posts", query

  getRequest:
    value: (path, params) ->
      url = "http://#{@siteAddress}/wp-json.php/#{path}"
      url += "?" + Reqwest.toQueryString params if params
      Reqwest url: url, type: "json", method: "get"

