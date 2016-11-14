class RouterActions
  constructor: ->
    @generateActions(
      'initData',
      'updateRouteData',
      'updateQuery',
      'updatePathname',
      'updateState',
      'updateMainRouter'
    )

namespace 'Appname.Admin', (exports) ->
  exports.RouterActions = alt.createActions(RouterActions)
