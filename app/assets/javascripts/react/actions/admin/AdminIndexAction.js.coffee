class AdminIndexActions
  constructor: ->
    @generateActions(
      'initData',
      'updateAdmins',
      'updatePageInfo',
      'updateFormMessage'
    )

namespace 'Appname.Admin', (exports) ->
  exports.AdminIndexActions = alt.createActions(AdminIndexActions)
