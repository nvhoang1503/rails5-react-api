class MenuActions
  constructor: ->
    @generateActions(
      'initData'
    )

namespace 'Appname.Admin', (exports) ->
  exports.MenuActions = alt.createActions(MenuActions)
